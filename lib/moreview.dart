import 'package:FidelWay/shared/utils.dart';
import 'package:flutter/material.dart';

import 'moreviewAPropos.dart';

class MoreView extends StatefulWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  _MoreViewState createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Utils.buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
/*              Image.asset(
                'images/worldcup.png',
                height: 160,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                margin: EdgeInsets.only(bottom: 3),
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 1,
                    child: ListTile(
                      leading: Icon(
                        Icons.stadium,
                        color: MyColors.grey3,
                      ),
                      title: Text("Stadiums"),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                margin: EdgeInsets.only(bottom: 3),
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 1,
                    child: ListTile(
                      leading: Icon(
                        Icons.stadium,
                        color: MyColors.grey3,
                      ),
                      title: Text("Matches"),
                    ),
                  ),
                ),
              ),*/

              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(bottom: 3),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AProposPage()));
                    },
                    child: const Card(
                      elevation: 1,
                      child: ListTile(
                        leading: Icon(
                          Icons.info,
                          color: Colors.grey,
                        ),
                        title: Text("à propos"),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
