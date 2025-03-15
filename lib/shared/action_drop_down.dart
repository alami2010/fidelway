import 'package:basic_dropdown_button/basic_dropwon_button_widget.dart';
import 'package:basic_dropdown_button/custom_dropdown_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class ActionDropDown extends StatelessWidget {
  const ActionDropDown({
    Key? key,
    required this.event,
    required this.currentIndex,
    required this.buttonStyle,
    required this.itemButtonStyle,
    required this.position,
    required this.text,
    required this.itemTextColor,
    required this.itemCount,
    required this.showAddChoiceDialog,
    required this.resetChoice,
    required this.defaultChoice,
    this.buttonTextStyle,
    this.iconColor,
  }) : super(key: key);
  final void Function(int) event;
  final int? currentIndex;

  final ButtonStyle buttonStyle;
  final ButtonStyle itemButtonStyle;
  final DropDownButtonPosition position;
  final String text;
  final TextStyle? buttonTextStyle;
  final Color? iconColor;
  final Color itemTextColor;
  final int itemCount;
  final VoidCallback? showAddChoiceDialog;
  final VoidCallback? resetChoice;
  final VoidCallback? defaultChoice;

  @override
  Widget build(BuildContext context) {
    return CustomDropDownButton<int>(
      buttonStyle: buttonStyle,
      buttonText: text,
      buttonChild: Row(children: <Widget>[
        Text(" Action ", style: kTextStyle.copyWith(color: Colors.black87)),
        const Icon(
          CupertinoIcons.settings_solid,
          color: Colors.black87,
        ),
      ]),
      position: position,
      buttonTextStyle: buttonTextStyle,
      menuItems: [
        CustomDropDownButtonItem(
          value: 1,
          text: "Ajouter une nouvelle récompense",
          icon: const Icon(
            CupertinoIcons.add_circled,
            color: Colors.black87,
          ),
          onPressed: showAddChoiceDialog,
          buttonStyle: itemButtonStyle,
          textStyle: TextStyle(
            color: itemTextColor,
          ),
        ),
        CustomDropDownButtonItem(
          value: 2,
          text: "Charger les récompenses par défaut",
          icon: const Icon(
            CupertinoIcons.settings_solid,
            color: Colors.black87,
          ),
          onPressed: defaultChoice,
          buttonStyle: itemButtonStyle,
          textStyle: TextStyle(
            color: itemTextColor,
          ),
        ),
        CustomDropDownButtonItem(
          value: 2,
          text: "Supprimer toutes les récompenses",
          icon: const Icon(
            CupertinoIcons.delete_solid,
            color: Colors.black87,
          ),
          onPressed: resetChoice,
          buttonStyle: itemButtonStyle,
          textStyle: TextStyle(
            color: itemTextColor,
          ),
        ),
      ],
      menuBorderRadius: BorderRadius.circular(
        2,
      ),
      selectedValue: currentIndex,
      buttonIcon: ({required showedMenu}) => showedMenu
          ? Icon(
              Icons.arrow_drop_down,
              color: iconColor,
            )
          : Icon(
              Icons.arrow_drop_up,
              color: iconColor,
            ),
    );
  }
}
