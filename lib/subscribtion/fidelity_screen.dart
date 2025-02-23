import 'package:FidelWay/home.dart';
import 'package:FidelWay/model/APIRest.dart';
import 'package:FidelWay/shared/local_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/category.dart';
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
    setState(() {
      isLoading = true;
    });

    try {
      LocalStorageHelper.saveCategory(selectedCategory);

      await APIRest.saveCategory(selectedCategory);

      Utils.showSucces("Choix bien sauvegarder");
      setState(() {
        isLoading = false;
      });
      const HomeScreen().launch(context);
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      Utils.showErreur("Erreur lors de sauvgarde de choix");
    }
  }

  void selectCategory(Category category) {
    setState(() {
      selectedCategory = category;
      if (category.id != selectedCategory?.id) {
        selectedCategory?.choices = category.choices;
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
      selectedCategory!.choices[index]["points"] =
          int.tryParse(newPoints) ?? selectedCategory!.choices[index]["points"];
    });
  }

  void removeChoice(int index) {
    setState(() {
      selectedCategory!.choices.removeAt(index);
      pointsControllers.removeAt(index);
    });
  }

  void showAddChoiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ajouter un choix"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: choiceController,
                  decoration: InputDecoration(labelText: "Nom du choix")),
              TextField(
                  controller: pointsController,
                  decoration: InputDecoration(labelText: "Points"),
                  keyboardType: TextInputType.number),
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
                addCustomChoice();
                Navigator.of(context).pop();
              },
              child: Text("Ajouter"),
            ),
          ],
        );
      },
    );
  }

  void addCustomChoice() {
    if (choiceController.text.isNotEmpty && pointsController.text.isNotEmpty) {
      setState(() {
        selectedCategory!.choices.add({
          "choice": choiceController.text,
          "points": int.tryParse(pointsController.text) ?? 0,
          "image": "images/default.png", // Image par défaut
        });
        pointsControllers
            .add(TextEditingController(text: pointsController.text));
        choiceController.clear();
        pointsController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Utils.buildDrawer(context),
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: ListTile(
          leading: selectedCategory != null
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: resetSelection,
                )
              : null,
          title: const FildelityBar(),
          trailing: !showCategories
              ? ElevatedButton(
                  onPressed: _saveChoices,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      "Enregisterer",
                      style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ))
              : null,
        ),
      ),
      body: Column(
        children: [
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
                            color: Color(0xFF4DCEFA),
                            width: 3.0,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        leading:
                            Image.asset(selectedCategory!.image, height: 50),
                        title: Text(
                          selectedCategory!.name,
                          maxLines: 2,
                          style: kTextStyle.copyWith(
                              color: kTitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
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
              style: kTextStyle.copyWith(
                  fontSize: 14,
                  color: kTitleColor,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  print(category.id);
                  print(selectedCategory?.id);
                  return Expanded(
                    child: Material(
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
                            color: category.id != selectedCategory?.id
                                ? Colors.white
                                : Color(0xFF4DCEFA),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(category.image, height: 120),
                              SizedBox(height: 20),
                              Text(
                                category.name,
                                style: kTextStyle.copyWith(
                                    fontSize: 14,
                                    color: kTitleColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
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
              child: new GestureDetector(
                onTap: showAddChoiceDialog,
                child: Container(
                  height: 40.0,
                  width: 200,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: kMainColor,
                  ),
                  child: Center(
                      child: Text(
                    "Ajouter un choix",
                    style: kTextStyle.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: selectedCategory!.choices.length,
                itemBuilder: (context, index) {
                  final choice = selectedCategory!.choices[index];

                  return Material(
                    child: Container(
                      width: context.width() * 0.95,
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Color(0xFF4DCEFA),
                            width: 3.0,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        leading:
                            Image.asset(choice["image"], height: 40, width: 40),
                        title: Text(
                          choice["choice"],
                          maxLines: 2,
                          style: kTextStyle.copyWith(
                              color: kTitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: TextField(
                          controller: pointsControllers[index],
                          keyboardType: TextInputType.number,
                          onChanged: (value) => updatePoints(index, value),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
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
}
