import 'package:fidelway/shared/local_storage_helper.dart';
import 'package:fidelway/shared/menu.dart';
import 'package:fidelway/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../shared/constant.dart';
import '../shared/language_provider.dart';
import 'model/APIRest.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  var account = LocalStorageHelper.getAccount();

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = account?.email ?? '';
  }

  Future<void> _sendContactRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await APIRest.sendContact(
        subject: _subjectController.text,
        message: _messageController.text,
        phone: _phoneController.text,
        email: _emailController.text,
      );

      setState(() => _isSubmitted = true);
      Utils.showSucces(AppLocalizations.of(context)!.messageSentSuccessfully,
          context: context);
      _formKey.currentState!.reset();
    } catch (e) {
      Utils.showErreur(
          "${AppLocalizations.of(context)!.errorSendingMessage}: ${e.toString()}",
          context: context);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.contactUs),
            backgroundColor: kMainColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeaderSection(),
            const SizedBox(height: 32),

            // Contact Form
            _buildContactForm(),

            // Alternative Contact Methods
            _buildAlternativeContactSection(),
          ],
        ),
      ),
    );
      },
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.contactTeam,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: kMainColor,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.contactDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildContactForm() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_isSubmitted)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    AppLocalizations.of(context)!.thankYouMessage,
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              TextFormField(
                controller: _emailController,
                decoration: _buildInputDecoration(
                  label: AppLocalizations.of(context)!.emailAddress,
                  icon: Icons.email_outlined,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterEmail;
                  }
                  if (!value.contains('@')) {
                    return AppLocalizations.of(context)!.pleaseEnterValidEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: _buildInputDecoration(
                  label: AppLocalizations.of(context)!.phoneNumberOptional,
                  icon: Icons.phone_outlined,
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                decoration: _buildInputDecoration(
                  label: AppLocalizations.of(context)!.subject,
                  icon: Icons.subject_outlined,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterSubject;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                decoration: _buildInputDecoration(
                  label: AppLocalizations.of(context)!.message,
                  icon: Icons.message_outlined,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterMessage;
                  }
                  if (value.length < 10) {
                    return AppLocalizations.of(context)!.messageTooShort;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _sendContactRequest,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: kMainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          AppLocalizations.of(context)!.sendMessage,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlternativeContactSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.otherContactMethods,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildContactMethod(
            icon: Icons.phone_outlined,
            title: AppLocalizations.of(context)!.byPhone,
            subtitle: AppLocalizations.of(context)!.callUsAt,
            color: Colors.blue[50]!,
          ),
          const SizedBox(height: 12),
          _buildContactMethod(
            icon: Icons.email_outlined,
            title: AppLocalizations.of(context)!.byEmail,
            subtitle: AppLocalizations.of(context)!.contactEmail,
            color: Colors.green[50]!,
          ),
        ],
      ),
    );
  }

  Widget _buildContactMethod({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Card(
      elevation: 0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kMainColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: kMainColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: kMainColor, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
    );
  }
}
