import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'shared/local_storage_helper.dart';
import 'shared/language_provider.dart';

class TypeFidelWay extends StatefulWidget {
  @override
  createState() {
    return new TypeFidelWayState();
  }
}

class TypeFidelWayState extends State<TypeFidelWay> {
  List<RadioModel> sampleData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeSampleData();
  }

  void _initializeSampleData() {
    var mode = LocalStorageHelper.readMode() ?? '';

    sampleData.add(RadioModel(1, mode.isEmpty || mode == 1.toString(), 'logo',
        AppLocalizations.of(context)!.defaultMode));
    sampleData.add(RadioModel(2, mode == 2.toString(), 'burger',
        AppLocalizations.of(context)!.burger));
    sampleData.add(RadioModel(
        3, mode == 3.toString(), 'pizza', AppLocalizations.of(context)!.pizza));
    sampleData.add(RadioModel(4, mode == 4.toString(), 'coiffeur',
        AppLocalizations.of(context)!.hairdresser));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        // Reinitialize sample data when language changes
        _initializeSampleData();

        return new Scaffold(
          appBar: new AppBar(
            title: new Text(AppLocalizations.of(context)!.applicationMode),
          ),
      body: new ListView.builder(
        itemCount: sampleData.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            //highlightColor: Colors.red,
            splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
                LocalStorageHelper.writeMode(sampleData[index].id);
              });
            },
            child: new RadioItem(sampleData[index]),
          );
        },
      ),
    );
      },
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: Image.asset(
                "images/" + _item.buttonText + ".png",
                width: 40,
              ),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected ? Colors.blueAccent : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Colors.blueAccent : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(_item.text),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  int id;
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.id, this.isSelected, this.buttonText, this.text);
}
