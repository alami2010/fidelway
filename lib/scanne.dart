import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:parallax_slide_animation/model/Client.dart';
import 'package:parallax_slide_animation/tabs.dart';

import 'local_storage_helper.dart';
import 'model/APIRest.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with TickerProviderStateMixin {
  bool notification = false;
  ClientWay client = ClientWay();
  MotionTabBarController? _motionTabBarController;

  void scanQrCode() {
    APIRest.scan("test_21-10-223xddddxxxxee").then((value) {
      setState(() {
        // adding a new marker to map
        client = value;
      });
    });
    /* FlutterBarcodeScanner.scanBarcode("#000000", "Sortir", true, ScanMode.QR)
        .then((value) {
      if (value != "-1") {
        APIRest.scan(value).then((value) {
          setState(() {
            // adding a new marker to map
            client = value;
          });
        });
      }
    });*/
  }

  @override
  void initState() {
    super.initState();
    //// Use normal tab controller
    // _tabController = TabController(
    //   initialIndex: 1,
    //   length: 4,
    //   vsync: this,
    // );

    //// use "MotionTabBarController" to replace with "TabController", if you need to programmatically change the tab
    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("holley");
    var mode = LocalStorageHelper.readMode();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 8),
                Tabs(),
                SizedBox(
                  height: 150,
                  child: Image.asset(
                    'assets/fidelway-logo.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(height: 8),
                Scanner(context),
                if (client.code != null)
                  InkWell(
                    onTap: () => setState(() {
                      // adding a new marker to map
                      client = ClientWay();
                    }),
                    child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 7, bottom: 5),
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Solde : ${client?.solde.toString() ?? ''}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                "Déconnexion",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )),
                  ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal, child: buildRow(mode)),
                if (client.history != null)
                  itemCard('', 'Historique des points'),
                if (client.history != null)
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      itemCount: client.history!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: itemCard(client.history?[index].date ?? '',
                              client.history?[index].amout.toString() ?? ''),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
/*
          ExhibitionBottomSheet(), //use this or ScrollableExhibitionSheet
*/
        ],
      ),
    );
  }

  Container Scanner(BuildContext context) {
    return Container(
        color: Color(0xFFFF5A1D),
        height: 100,
        margin: EdgeInsets.only(left: 7, bottom: 5),
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    scanQrCode();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Scannez',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }

  Row buildRow(String? mode) {
    List<String> list = client.fastFoodRepas ?? [];

    return Row(
      children: [
        for (int i = 0; i < list.length; i++)
          InkWell(
            onTap: () {
              APIRest.minus(client.code ?? '', getAmount(list[i]))
                  .then((value) {
                setState(() {
                  // adding a new marker to map
                  client = value;
                });
              });
            },
            child: Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.only(left: 7, bottom: 5),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        "assets/${list[i]}.png",
                        height: 100,
                        width: 80,

                      ),
                    ],
                  ),
                )),
          )
      ],
    );
  }

  int getAmount(String repas) {
    if (repas == "coca") {
      return 10;
    } else if (repas == "burger") {
      return 20;
    } else if (repas == "menu") {
      return 15;
    } else if (repas == "coca_pizza") {
      return 3;
    } else if (repas == "pizza") {
      return 15;
    } else if (repas == "pizzas") {
      return 200;
    } else if (repas == "coiffeur") {
      return 6;
    }

    return 0;
  }

  Widget itemCard(String date, String point) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.grey),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 2,
              ),
              Container(
                  child: ListTile(
                leading: Text(
                  point.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0),
                ),
                title: Text(
                  date,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0),
                ),
              )),
            ],
          )),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        'FidelWAy',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class MainPageContentComponent extends StatelessWidget {
  const MainPageContentComponent({
    required this.title,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final String title;
  final MotionTabBarController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          const Text('Go to "X" page programmatically'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => controller.index = 0,
            child: const Text('Dashboard Page'),
          ),
          ElevatedButton(
            onPressed: () => controller.index = 1,
            child: const Text('Home Page'),
          ),
          ElevatedButton(
            onPressed: () => controller.index = 2,
            child: const Text('Profile Page'),
          ),
          ElevatedButton(
            onPressed: () => controller.index = 3,
            child: const Text('Settings Page'),
          ),
        ],
      ),
    );
  }
}
