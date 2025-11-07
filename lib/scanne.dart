import 'package:fidelway/shared/constant.dart';
import 'package:fidelway/subscribtion/scan_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:provider/provider.dart';

import 'model/APIRest.dart';
import 'model/choice_result.dart';
import 'shared/language_provider.dart';
import 'shared/local_storage_helper.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with TickerProviderStateMixin {
  bool notification = false;
  ChoiceResult client = ChoiceResult();
  MotionTabBarController? _motionTabBarController;
  bool isLoading = false;

  Future<void> scanQrCode() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = (kIsWeb)
          ? "https://votre-site.com/carte-54"
          : await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
            );

      if (result != null) {
        final value = await APIRest.scan(getLastSegment(result));
        setState(() {
          client = value;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${AppLocalizations.of(context)!.errorScanning}: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String getLastSegment(String input) {
    // Remove trailing slash if any
    input = input.endsWith('/') ? input.substring(0, input.length - 1) : input;

    // Split and return the last segment
    final parts = input.split('/');
    return parts.isNotEmpty ? parts.last : '';
  }

  void resetClient() {
    setState(() {
      client = ChoiceResult();
    });
  }

  void redeemPoints(Choices choice) async {
    setState(() {
      isLoading = true;
    });

    try {
      final value = await APIRest.minus(client.code ?? '', choice.points ?? 0);
      setState(() {
        client = value;
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${choice.points} ${AppLocalizations.of(context)!.pointsExchangedSuccessfully}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${AppLocalizations.of(context)!.errorExchanging}: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 4,
      vsync: this,
    );

    // Initialize the showHistory state
    showHistory = false;
  }

  @override
  void dispose() {
    _motionTabBarController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        var mode = LocalStorageHelper.readMode();
        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              if (client.code != null) {
                final value = await APIRest.scan(client.code!);
                setState(() {
                  client = value;
                });
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildScannerCard(),
                  ),
                  const SizedBox(height: 20),
                  if (client.code != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildClientInfoCard(),
                    ),
                  if (client.code != null) const SizedBox(height: 24),
                  if (client.choices != null && client.choices!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildRewardsSection(mode),
                    ),
                  if (client.history != null && client.history!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildHistorySection(),
                    ),
                  const SizedBox(height: 100), // Extra space at bottom for scrolling
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kMainColor),
                ),
              ),
            ),
        ],
      ),
    );
      },
    );
  }

  Widget _buildScannerCard() {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: scanQrCode,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFFFF5A1D), Color(0xFFFF8C00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
                size: 60,
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.scanCard,
                style: kTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.accumulateOrUsePoints,
                style: kTextStyle.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClientInfoCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kMainColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.stars,
                        color: kMainColor,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.yourPoints,
                          style: kTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          '${client.solde ?? 0}',
                          style: kTextStyle.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: kTitleColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: resetClient,
                  icon: const Icon(Icons.logout, size: 18),
                  label: Text(AppLocalizations.of(context)!.quit),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAlertColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardsSection(String? mode) {
    List<Choices> list = client.choices ?? [];
    list.sort((a, b) => (a.points ?? 0).compareTo(b.points ?? 0));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.card_giftcard,
                color: kMainColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)!.availableRewards,
                style: kTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kTitleColor,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final choice = list[index];
            final bool isDisabled = (client.solde ?? 0) < (choice.points ?? 0);

            return Card(
              clipBehavior: Clip.antiAlias,
              elevation: isDisabled ? 1 : 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isDisabled ? Colors.grey.withOpacity(0.2) : Colors.transparent,
                  width: 1,
                ),
              ),
              child: InkWell(
                onTap: isDisabled ? null : () => redeemPoints(choice),
                child: Container(
                  color: isDisabled ? Colors.grey.withOpacity(0.05) : Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              width: double.infinity,
                              child: Image.asset(
                                "assets/${choice.image}",
                                fit: BoxFit.contain,
                              ),
                            ),
                            if (isDisabled)
                              Container(
                                color: Colors.white.withOpacity(0.6),
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .insufficientPoints,
                                      style: kTextStyle.copyWith(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDisabled
                                ? [Colors.grey.withOpacity(0.2), Colors.grey.withOpacity(0.1)]
                                : [kMainColor.withOpacity(0.2), kMainColor.withOpacity(0.05)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              getLocalizedChoiceNameFromChoices(
                                  context, choice),
                              style: kTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDisabled ? Colors.grey[600] : kTitleColor,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isDisabled ? Colors.grey : kMainColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: isDisabled
                                    ? []
                                    : [
                                        BoxShadow(
                                          color: kMainColor.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                              ),
                              child: Text(
                                '${choice.points} ${AppLocalizations.of(context)!.points}',
                                style: kTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  bool showHistory = false;

  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            setState(() {
              showHistory = !showHistory;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.history,
                      color: kMainColor,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      AppLocalizations.of(context)!.transactionHistory,
                      style: kTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kTitleColor,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                Icon(
                  showHistory ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: kMainColor,
                ),
              ],
            ),
          ),
        ),
        if (showHistory)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: client.history?.length ?? 0,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.grey.withOpacity(0.2),
                ),
                itemBuilder: (context, index) {
                  final historyItem = client.history![index];
                  final isPositive = (historyItem.amout ?? 0) > 0;

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPositive ? Icons.add_circle : Icons.remove_circle,
                        color: isPositive ? Colors.green : Colors.red,
                        size: 24,
                      ),
                    ),
                    title: Text(
                      historyItem.date ?? '',
                      style: kTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        '${isPositive ? "+" : ""}${historyItem.amout} pts',
                        style: kTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: isPositive ? Colors.green[700] : Colors.red[700],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}