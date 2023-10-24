import 'package:FidelWay/tabs.dart';
import 'package:flutter/material.dart';

class AProposPage extends StatefulWidget {
  const AProposPage({Key? key}) : super(key: key);

  @override
  _AProposPageState createState() => _AProposPageState();
}

class _AProposPageState extends State<AProposPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Tabs(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
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
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                margin: EdgeInsets.only(bottom: 3),
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 1,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.notes,
                            color: Colors.grey,
                          ),
                          title: Text("CONTACTEZ NOUS"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                              "Appelez-nous ou passez nous voir à tout moment, nous nous efforçons de répondre à toutes les demandes dans les 24 heures tous les jours ouvrables. Nous serons heureux de répondre à vos questions."),
                        )
                      ],
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
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.mail,
                            color: Colors.grey,
                          ),
                          title: Text("Email"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text("contact.bway22@gmail.com"),
                        )
                      ],
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
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                          title: Text("Téléphone"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text("+33 6 32 98 46 29"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text("+212 6 04 64 60 89"),
                        )
                      ],
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
}
