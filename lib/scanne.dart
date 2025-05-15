import 'package:fidelway/shared/constant.dart';
import 'package:fidelway/subscribtion/scan_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:nb_utils/nb_utils.dart';

import 'model/APIRest.dart';
import 'model/choice_result.dart';
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

  Future<void> scanQrCode() async {
    /*   APIRest.scan("test_21-10-000x00x3x").then((value) {
      setState(() {
        // adding a new marker to map
        client = value;
      });
    });*/

    print('scanQrCode');
    final result = (kIsWeb)
        ? "test_21-10-000x00x3x"
        : await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
          );
    print(result);
    print('scanQrCode---------');
    if (result != null) {
      APIRest.scan(result).then((value) {
        setState(() {
          // adding a new marker to map
          client = value;
        });
      });
    }
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
    var mode = LocalStorageHelper.readMode();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                      client = ChoiceResult();
                    }),
                    child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 7, bottom: 5),
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  width: context.width() / 2,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: const Border(
                                        left: BorderSide(
                                      color: kAlertColor,
                                      width: 3.0,
                                    )),
                                    color: kAlertColor.withOpacity(0.1),
                                  ),
                                  child: Text(
                                    'Solde : ${client?.solde.toString() ?? ''} points',
                                    style: kTextStyle.copyWith(color: kTitleColor, fontSize: 20.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () => setState(() {
                                    // adding a new marker to map
                                    client = ChoiceResult();
                                  }),
                                  child: Container(
                                      width: context.width() / 3,
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        border: const Border(
                                            left: BorderSide(
                                          color: kAlertColor,
                                          width: 3.0,
                                        )),
                                        color: kMainColor.withOpacity(0.1),
                                      ),
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Déconnexion",
                                        style: kTextStyle,
                                      )),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                SingleChildScrollView(scrollDirection: Axis.horizontal, child: showChoice(mode)),
                if (client.history != null) itemCard('', 'Historique des points'),
                if (client.history != null)
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      itemCount: client.history!.length,
                      itemBuilder: (context, index) {
                        return itemCard(client.history?[index].date ?? '', client.history?[index].amout.toString() ?? '');
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
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    scanQrCode();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Scanner une carte',
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

  Row showChoice(String? mode) {
    List<Choices> list = client.choices ?? [];

    // Sort the list of choices based on their points
    list.sort((a, b) => (a.points ?? 0).compareTo(b.points ?? 0));

    return Row(
      children: [
        for (int i = 0; i < list.length; i++)
          InkWell(
            onTap: () {
              APIRest.minus(client.code ?? '', list[i].points ?? 0).then((value) {
                setState(() {
                  // adding a new marker to map
                  client = value;
                });
              });
            },
            child: Container(
                height: 170,
                width: 100,
                margin: EdgeInsets.only(left: 7, bottom: 5),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ListTile(
                        subtitle: Text(
                          list[i]?.points.toString() ?? '',
                          style: kTextStyle.copyWith(fontSize: 10.0),
                        ),
                        title: Text(list[i]?.choice ?? '', style: kTextStyle.copyWith(fontSize: 12.0)),
                      ),
                      Image.asset(
                        "assets/${list[i].image}",
                        height: 100,
                        width: 100,
                      ),
                    ],
                  ),
                )),
          )
      ],
    );
  }

  Widget itemCard(String date, String point) {
    return Padding(
      padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
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
                  '$point points',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12.0),
                ),
                title: Text(
                  date,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12.0),
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

