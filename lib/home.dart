import 'package:fidelway/shared/constant.dart';
import 'package:fidelway/shared/utils.dart';
import 'package:fidelway/tabs.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

import 'new_client.dart';
import 'scanne.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, AfterLayoutMixin {
  // TabController? _tabController;
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const FildelityBar(),
      ),
      drawer: Utils.buildDrawer(context),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        // ADD THIS if you need to change your tab programmatically
        initialSelectedTab: "FidelWay",
        useSafeArea: false,
        // default: true, apply safe area wrapper
        labels: const ["FidelWay", "Nouveau"],
        icons: const [
          Icons.dashboard,
          Icons.add,
        ],

        tabSize: 40,
        tabBarHeight: 55,
        textStyle: kTextStyle.copyWith(color: Colors.white),
        tabIconColor: kAlertColor,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: kAlertColor,
        tabIconSelectedColor: Colors.white,
        tabBarColor: kMainColor,
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        // swipe navigation handling is not supported
        controller: _motionTabBarController,
        children: const <Widget>[ScanPage(), GenerateScreen()],
      ),
    );
  }

}
