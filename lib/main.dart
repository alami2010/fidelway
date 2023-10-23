import 'package:flutter/material.dart';
import 'package:parallax_slide_animation/first-time.dart';

import 'home.dart';
import 'local_storage_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var isFirstTime = LocalStorageHelper.readShopName()?.isNotEmpty ?? false;

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isFirstTime ? const MyHomePage() : FirstTime(),
    );
  }
}
