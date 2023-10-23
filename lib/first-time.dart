import 'package:flutter/material.dart';
import 'package:parallax_slide_animation/home.dart';

import 'local_storage_helper.dart';

class FirstTime extends StatelessWidget {
  FirstTime({super.key});

  static const welcomeImage = './assets/welcome.jpg';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Center(
        child: AdaptiveScaffold(
          compact: CompactView(welcomeImage: welcomeImage, formKey: _formKey),
          full: FullView(welcomeImage: welcomeImage, formKey: _formKey),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    print(LocalStorageHelper.readShopName());
    _nameController.text = LocalStorageHelper.readShopName() ?? "";
    _priceController.text = LocalStorageHelper.readOffert() ?? "";
    _numberController.text = LocalStorageHelper.readCountVisit() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Veuillez entrer le nom de votre boutique"
            " et le montant que vous allez offrire lorsque le client fait le nombe de visite",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Form(
            key: widget._formKey,
            child: Column(children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nom Boutique *',
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre de viste * ',
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Offert *',
                ),
              )
            ]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              if (_nameController.text.isNotEmpty &&
                  _numberController.text.isNotEmpty &&
                  _priceController.text.isNotEmpty) {
                Navigator.pop(context);
                LocalStorageHelper.writeShopName(_nameController.text);
                LocalStorageHelper.writeCountVisit(_numberController.text);
                LocalStorageHelper.writeOffert(_priceController.text);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Merci de remplir tout les champs"),
                ));
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(1024, 60),
            ),
            child: const Text(
              'Valider',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key? key,
    required this.welcomeImage,
  }) : super(key: key);

  final String welcomeImage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(welcomeImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 24,
          child: Text(
            'Bienvenue sur \n FildeWay.',
            maxLines: 2,
            style: textTheme.headline4!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 24,
          left: 24,
          child: Row(
            children: [
              const Icon(
                Icons.sunny_snowing,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(width: 8),
              Text(
                'FidelWay.',
                maxLines: 2,
                style: textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CompactView extends StatelessWidget {
  const CompactView({
    Key? key,
    required this.welcomeImage,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final String welcomeImage;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: HeroImage(welcomeImage: welcomeImage),
          ),
          LoginForm(formKey: _formKey),
        ],
      );
    });
  }
}

class FullView extends StatelessWidget {
  const FullView({
    Key? key,
    required this.welcomeImage,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final String welcomeImage;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Flexible(child: LoginForm(formKey: _formKey)),
          Flexible(
            child: HeroImage(welcomeImage: welcomeImage),
          ),
        ],
      );
    });
  }
}

class AdaptiveScaffold extends StatelessWidget {
  final Widget full;
  final Widget compact;

  const AdaptiveScaffold({
    required this.full,
    required this.compact,
    super.key,
  });

  factory AdaptiveScaffold.single({required Widget body}) {
    return AdaptiveScaffold(full: body, compact: body);
  }

  factory AdaptiveScaffold.multi({
    required Widget full,
    required Widget compact,
  }) {
    return AdaptiveScaffold(full: full, compact: compact);
  }

  @override
  Widget build(Object context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.isMobile) {
        return Scaffold(body: compact);
      } else {
        return Scaffold(body: full);
      }
    });
  }
}

extension BreakpointUtils on BoxConstraints {
  bool get isTablet => maxWidth > 730;

  bool get isDesktop => maxWidth > 1200;

  bool get isMobile => !isTablet && !isDesktop;
}
