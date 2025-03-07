import 'dart:async';

import 'package:basic_dropdown_button/basic_dropwon_button_widget.dart';
import 'package:fidelway/home.dart';
import 'package:fidelway/model/APIRest.dart';
import 'package:fidelway/shared/local_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/category.dart';
import '../shared/action_drop_down.dart';
import '../shared/constant.dart';
import '../shared/utils.dart';
import '../tabs.dart';

class FidelityScreen extends StatefulWidget {
  @override
  _FidelityScreenState createState() => _FidelityScreenState();
}

class _FidelityScreenState extends State<FidelityScreen> {
  bool isLoading = false;
  Category? selectedCategory;
  bool showCategories = true;
  final TextEditingController choiceController = TextEditingController();
  final TextEditingController pointsController = TextEditingController();
  List<TextEditingController> pointsControllers = [];

  @override
  void initState() {
    super.initState();
    _loadChoices();
  }

  Future<void> _loadChoices() async {
    selectedCategory = LocalStorageHelper.getCategory();

    setState(() {
      selectedCategory = LocalStorageHelper.getCategory();
      if (selectedCategory != null) {
        showCategories = false;
        _initializeControllers();
      }
    });
  }

  Future<void> _saveChoices() async {
    startloading();

    try {
      LocalStorageHelper.saveCategory(selectedCategory);

      await APIRest.saveCategory(selectedCategory);

      Utils.showSucces("Choix bien sauvegarder");
      stopLoading();
      const HomeScreen().launch(context);
    } catch (error) {
      stopLoading();
      Utils.showErreur("Erreur lors de sauvgarde de choix");
    }
  }

  void startloading() {
    setState(() {
      isLoading = true;
    });
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  void selectCategory(Category category) {
    setState(() {
      selectedCategory = category.copyWith();
      if (category.id != selectedCategory?.id) {
        selectedCategory?.choices = List.from(category.choices);
      }

      _initializeControllers();
      showCategories = false;
    });
  }

  void resetSelection() {
    setState(() {
      showCategories = true;
    });
  }

  void _initializeControllers() {
    pointsControllers = selectedCategory!.choices.map((choice) {
      return TextEditingController(text: choice["points"].toString());
    }).toList();
  }

  void updatePoints(int index, String newPoints) {
    print('updatePoints');
    setState(() {
      selectedCategory!.choices[index]["points"] = int.tryParse(newPoints) ?? selectedCategory!.choices[index]["points"];
    });
  }

  void removeChoice(int index) {
    setState(() {
      selectedCategory!.choices.removeAt(index);
      pointsControllers.removeAt(index);
    });
  }

  void addCustomChoice() {
    print('addCustomChoice');
    print(choiceController.text);
    print('addCustomChoice');
    print(pointsController.text);
    print('addCustomChoice');

    if (choiceController.text.isNotEmpty && pointsController.text.isNotEmpty) {
      print('addCustomChoicex');

      setState(() {
        selectedCategory!.choices.add({
          "choice": choiceController.text,
          "points": int.tryParse(pointsController.text) ?? 0,
          "image": "images/default.png", // Image par défaut
        });
        pointsControllers.add(TextEditingController(text: pointsController.text));
        choiceController.clear();
        pointsController.clear();
      });
    }
  }

  void addChoiceFromCategory(Map<String, dynamic> choice) {
    // Implement the logic to add the selected choice from a category
    setState(() {
      selectedCategory!.choices.add({
        "choice": choice["choice"],
        "points": choice["points"],
        "image": choice["image"], // Image par défaut
      });
      pointsControllers.add(TextEditingController(text: pointsController.text));
      choiceController.clear();
      pointsController.clear();
    });
    print("Added choice from category: ${choice["choice"]} with ${choice["points"]} points");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Utils.buildDrawer(context),
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const ListTile(
          leading: null,
          title: FildelityBar(),
        ),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
          if (!showCategories) ...[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Material(
                    child: Container(
                      width: context.width() * 0.95,
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: kAlertColor,
                            width: 3.0,
                          ),
                        ),
                        color: const Color(0xFFDAF3FF),
                      ),
                      child: ListTile(
                        leading: Image.asset("assets/${selectedCategory!.image}", height: 50),
                        title: Text(
                          selectedCategory!.name,
                          maxLines: 2,
                          style: kTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: resetSelection,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
          if (showCategories) ...[
            Text(
              "Choisissez une catégorie :",
              style: kTextStyle.copyWith(fontSize: 14, color: kTitleColor, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  print(category.id);
                  print(selectedCategory?.id);
                  return Material(
                    elevation: 2.0,
                    child: GestureDetector(
                      onTap: () => selectCategory(category),
                      child: Container(
                        width: context.width(),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: category.color,
                              width: 3.0,
                            ),
                          ),
                          color: category.id != selectedCategory?.id ? Colors.white : kMainColorLight,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/${category.image}", height: 120),
                            const SizedBox(height: 20),
                            Text(
                              category.name,
                              style: kTextStyle.copyWith(fontSize: 14, color: kTitleColor, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          if (!showCategories) ...[
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: _saveChoices,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          "Enregisterer",
                          style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                      )),
                  const Spacer(),
                  if (isLoading) Utils.getLoading(),
                  const Spacer(),
                  ActionDropDown(
                    event: (index) => setState(() {}),
                    position: DropDownButtonPosition.bottomRight,
                    buttonStyle: _buttonStyle6,
                    itemButtonStyle: _itemButtonStyle6,
                    buttonTextStyle: kTextStyle,
                    iconColor: kMainColor,
                    itemTextColor: kMainColor,
                    itemCount: 4,
                    currentIndex: 0,
                    text: 'x',
                    resetChoice: resetChoice,
                    showAddChoiceDialog: showAddChoiceDialog,
                    defaultChoice: defaultChoice,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: selectedCategory!.choices.length,
                itemBuilder: (context, index) {
                  final choice = selectedCategory!.choices[index];

                  return Material(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: kMainColorLight,
                            width: 3.0,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        leading: Image.asset("assets/" + choice["image"], height: 40, width: 40),
                        title: Text(
                          choice["choice"],
                          maxLines: 2,
                          style: kTextStyle.copyWith(color: kTitleColor, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: TextField(
                          controller: pointsControllers[index],
                          keyboardType: TextInputType.number,
                          onChanged: (value) => updatePoints(index, value),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => removeChoice(index),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  ButtonStyle get _buttonStyle6 => TextButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(20),
        textStyle: kTextStyle,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2), side: const BorderSide(color: kMainColor)),
      );

  ButtonStyle get _itemButtonStyle6 => TextButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(10),
        textStyle: kTextStyle,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1), side: const BorderSide(color: kMainColor)),
      );

  void showAddChoiceDialog() {
    bool isManualEntry = false;

    Map<String, dynamic>? selectedChoice; // Stores the selected choice from a category

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Ajouter un choix"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Toggle between manual and category selection
                  Row(
                    children: [
                      Text('Manual Entry'),
                      Switch(
                        value: isManualEntry,
                        onChanged: (value) {
                          setState(() {
                            isManualEntry = value;
                            selectedChoice = null; // Reset selected choice
                          });
                        },
                      ),
                    ],
                  ),
                  if (isManualEntry) ...[
                    TextField(
                      controller: choiceController,
                      decoration: const InputDecoration(labelText: "Nom du choix"),
                    ),
                    TextField(
                      controller: pointsController,
                      decoration: const InputDecoration(labelText: "Points"),
                      keyboardType: TextInputType.number,
                    ),
                  ] else ...[
                    Column(
                      children: [
                        SizedBox(
                          height: 200, // Set a fixed height for the scrollable list
                          width: 200,
                          child: ListView.builder(
                            itemCount: categories.firstWhere((cat) => cat.id.toString() == selectedCategory?.id.toString()).choices.length,
                            itemBuilder: (context, index) {
                              final choice = categories.firstWhere((cat) => cat.id.toString() == selectedCategory?.id.toString()).choices[index];
                              return ListTile(
                                title: Text(choice["choice"]),
                                subtitle: Text("Points: ${choice["points"]}"),
                                onTap: () {
                                  setState(() {
                                    selectedChoice = choice; // Store the selected choice
                                    pointsController.text = choice["points"].toString(); // Pre-fill points
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    if (selectedChoice != null) ...[
                      SizedBox(height: 16),
                      TextField(
                        controller: pointsController,
                        decoration: InputDecoration(labelText: "Points"),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // Update the points in the selected choice
                          selectedChoice!["points"] = int.tryParse(value) ?? 0;
                        },
                      ),
                    ],
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Annuler"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (isManualEntry) {
                      addCustomChoice();
                    } else if (selectedChoice != null) {
                      addChoiceFromCategory(selectedChoice!);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text("Ajouter"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void resetChoice() {
    startloading();
    setState(() {
      selectedCategory!.choices.clear();
      _initializeControllers();
    });
    stopLoading();
  }

  void defaultChoice() {
    startloading();
    List<Map<String, dynamic>> choices = List.from(categories.firstWhere((cat) => cat.id == selectedCategory?.id).choices);
    print("choices");
    print(selectedCategory?.id);

    print(categories.firstWhere((cat) => cat.id == selectedCategory?.id));

    print(choices);
    setState(() {
      selectedCategory!.choices = choices;
    });
    _initializeControllers();
    stopLoading();
  }
}
