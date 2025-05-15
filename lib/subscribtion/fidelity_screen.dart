import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../home.dart';
import '../model/APIRest.dart';
import '../model/category.dart';
import '../shared/constant.dart';
import '../shared/local_storage_helper.dart';
import '../shared/menu.dart';
import '../shared/utils.dart';

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
    startLoading();

    try {
      LocalStorageHelper.saveCategory(selectedCategory);

      await APIRest.saveCategory(selectedCategory);

      Utils.showSucces("Choix bien sauvegarder", context: context);
      stopLoading();
      const HomeScreen().launch(context);
    } catch (error) {
      stopLoading();
      Utils.showErreur("Erreur lors de sauvgarde de choix", context: context);
    }
  }

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  Future<void> selectCategory(Category category) async {
    bool? result = await Utils.showYesNoDialog(context, "En changeant de métier, votre configuration sera perdue. Continuer ?  ");
    if (result == true) {
      setState(() {
        selectedCategory = category.copyWith();
        if (category.id != selectedCategory?.id) {
          selectedCategory?.choices = List.from(category.choices);
        }

        _initializeControllers();
        showCategories = false;
      });
    }
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
    if (choiceController.text.isNotEmpty && pointsController.text.isNotEmpty) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Programme de fidélité'),
        backgroundColor: kMainColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          if (!showCategories) _buildCategoryHeader(),
          Expanded(
            child: showCategories ? _buildCategorySelection() : _buildRewardsManagement(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: selectedCategory?.color.withOpacity(0.2),
            child: Image.asset(
              "assets/${selectedCategory?.image}",
              height: 30,
              width: 30,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedCategory?.name ?? '',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${selectedCategory?.choices.length ?? 0} récompenses configurées',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: kMainColor),
            onPressed: resetSelection,
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sélectionnez votre secteur d\'activité',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Choisissez la catégorie qui correspond à votre commerce pour configurer votre programme de fidélité',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return _buildCategoryCard(category);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Category category) {
    final isSelected = category.id == selectedCategory?.id;

    return InkWell(
      onTap: () => selectCategory(category),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isSelected ? category.color.withOpacity(0.4) : Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 4),
              spreadRadius: isSelected ? 1 : 0,
            ),
          ],
          border: Border.all(
            color: isSelected ? category.color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/${category.image}",
                height: 48,
                width: 48,
              ),
            ),
            SizedBox(height: 16),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${category.choices.length} récompenses',
                style: TextStyle(
                  color: category.color,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardsManagement() {
    return Column(
      children: [
        _buildActionButtons(),
        Divider(height: 1),
        Expanded(
          child: selectedCategory?.choices.isEmpty ?? true
              ? _buildEmptyState()
              : ListView.separated(
                  padding: EdgeInsets.all(16),
                  itemCount: selectedCategory!.choices.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final choice = selectedCategory!.choices[index];
                    return _buildRewardCard(choice, index);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primary and secondary actions
          Row(
            children: [
              // Main action button with icon
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _saveChoices,
                  icon: const Icon(Icons.save_rounded, size: 18),
                  label: const Text('Enregistrer', style: TextStyle(fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kMainColor,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Secondary action - Add reward
              OutlinedButton.icon(
                onPressed: showAddChoiceDialog,
                icon: const Icon(Icons.add_circle_outline, size: 18),
                label: const Text('Ajouter', style: TextStyle(fontWeight: FontWeight.w500)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: kMainColor,
                  side: BorderSide(color: kMainColor.withOpacity(0.5)),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Spacer(),

              // Management options in a dropdown
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PopupMenuButton(
                  tooltip: 'Options',
                  icon: Icon(Icons.settings, color: Colors.grey[700], size: 20),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  position: PopupMenuPosition.under,
                  itemBuilder: (context) => [
                    _buildPopupMenuItem(
                      icon: Icons.restore,
                      text: 'Réinitialiser par défaut',
                      onTap: defaultChoice,
                    ),
                    _buildPopupMenuItem(
                      icon: Icons.delete_outline,
                      text: 'Tout supprimer',
                      onTap: resetChoice,
                      isDestructive: true,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Loading indicator and management options row
          Row(
            children: [
              // Loading indicator with text
              if (isLoading) ...[
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(kMainColor),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Traitement en cours...',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

// Helper method to build consistent menu items
  PopupMenuItem _buildPopupMenuItem({
    required IconData icon,
    required String text,
    required Function onTap,
    bool isDestructive = false,
  }) {
    final Color textColor = isDestructive ? Colors.red : Colors.black87;

    return PopupMenuItem(
      onTap: () async => await onTap(),
      child: Row(
        children: [
          Icon(icon, size: 18, color: textColor),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: isDestructive ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.card_giftcard, size: 64, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'Aucune récompense configurée',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Ajoutez des récompenses pour votre programme de fidélité',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: showAddChoiceDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: kMainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text('Ajouter une récompense'),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardCard(Map<String, dynamic> choice, int index) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and delete button
            Row(
              children: [
                Expanded(
                  child: Text(
                    choice["choice"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.3,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                // More prominent, tactile delete button
                Material(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => removeChoice(index),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(Icons.delete_outline, color: Colors.red.shade700, size: 20),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            // Image and points input in a row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image container with enhanced styling
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/${choice["image"]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Points input field
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: pointsControllers[index],
                        keyboardType: TextInputType.number,
                        onChanged: (value) => updatePoints(index, value),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixText: 'points',
                          suffixStyle: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void showAddChoiceDialog() {
    bool isManualEntry = false;
    Map<String, dynamic>? selectedChoice;

    // Theme colors
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color backgroundColor = Colors.grey[50]!;
    final Color cardColor = Colors.white;
    final Color accentColor = Theme.of(context).colorScheme.secondary;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              backgroundColor: backgroundColor,
              child: Container(
                padding: EdgeInsets.all(24),
                constraints: BoxConstraints(maxWidth: 450, maxHeight: 600),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ajouter une récompense",
                              style: kTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Un achat = 10 points",
                              style: kTextStyle.copyWith(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.grey[600]),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    Divider(height: 24),

                    // Entry type selector
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Prédéfini',
                                style: TextStyle(
                                  color: !isManualEntry ? primaryColor : Colors.grey,
                                  fontWeight: !isManualEntry ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              Switch(
                                value: isManualEntry,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    isManualEntry = value;
                                    selectedChoice = null;
                                  });
                                },
                              ),
                              Text(
                                'Personnalisé',
                                style: TextStyle(
                                  color: isManualEntry ? primaryColor : Colors.grey,
                                  fontWeight: isManualEntry ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),

                    // Content based on selected entry type
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(16),
                        child: isManualEntry
                            ? _buildManualEntryForm()
                            : _buildCategorySelectionForm(setState, selectedChoice, primaryColor, accentColor),
                      ),
                    ),

                    SizedBox(height: 24),

                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            side: BorderSide(color: Colors.grey[400]!),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Annuler",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            if (isManualEntry) {
                              addCustomChoice();
                            } else if (selectedChoice != null) {
                              addChoiceFromCategory(selectedChoice!);
                            }
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Ajouter",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

// Manual entry form
  Widget _buildManualEntryForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Saisie manuelle',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: choiceController,
          decoration: InputDecoration(
            labelText: "Nom de la récompense",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            fillColor: Colors.grey[100],
            filled: true,
            prefixIcon: Icon(Icons.card_giftcard),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: pointsController,
          decoration: InputDecoration(
            labelText: "Points nécessaires",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            fillColor: Colors.grey[100],
            filled: true,
            prefixIcon: Icon(Icons.star),
            suffixText: "points",
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

// Category selection form
  Widget _buildCategorySelectionForm(StateSetter setState, Map<String, dynamic>? selectedChoice, Color primaryColor, Color accentColor) {
    final category = categories.firstWhere(
      (cat) => cat.id.toString() == selectedCategory?.id.toString(),
      orElse: () => Category(id: -1, name: '', image: '', color: Colors.black, choices: []),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sélectionnez une récompense',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          'Catégorie: ${category.name}',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            itemCount: category.choices.length,
            separatorBuilder: (_, __) => SizedBox(height: 8),
            itemBuilder: (context, index) {
              final choice = category.choices[index];
              final bool isSelected = selectedChoice == choice;

              return Card(
                elevation: isSelected ? 3 : 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: isSelected ? primaryColor : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedChoice = choice;
                      pointsController.text = choice["points"].toString();
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withOpacity(0.1) : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.card_giftcard,
                            color: isSelected ? primaryColor : Colors.grey[600],
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                choice["choice"],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? primaryColor : Colors.black87,
                                ),
                              ),
                              Text(
                                "${choice["points"]} points",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: primaryColor,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (selectedChoice != null) ...[
          SizedBox(height: 16),
          TextFormField(
            controller: pointsController,
            decoration: InputDecoration(
              labelText: "Ajuster les points",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: Colors.grey[100],
              filled: true,
              prefixIcon: Icon(Icons.edit),
              suffixText: "points",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              selectedChoice!["points"] = int.tryParse(value) ?? 0;
            },
          ),
        ],
      ],
    );
  }
  Future<void> resetChoice() async {
    bool? result = await Utils.showYesNoDialog(context, "Êtes-vous sûr de vouloir supprimer toutes les récompenses ?");
    if (result == true) {
      startLoading();
      setState(() {
        selectedCategory!.choices.clear();
        _initializeControllers();
      });
      stopLoading();
    }
  }

  Future<void> defaultChoice() async {
    bool? result = await Utils.showYesNoDialog(context, "Êtes-vous sûr de vouloir réinitialiser les récompenses par défaut ?");
    if (result == true) {
      startLoading();
      List<Map<String, dynamic>> choices = List.from(categories.firstWhere((cat) => cat.id == selectedCategory?.id).choices);

      setState(() {
        selectedCategory!.choices = choices;
      });
      _initializeControllers();
      stopLoading();
    }
  }
}
