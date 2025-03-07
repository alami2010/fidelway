import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/category.dart';

const kMainColor = Color(0xFF007AFF);
const kMainColorLight = Color(0xFF4DCEFA);
const kGreyTextColor = Color(0xFF9090AD);
const kBorderColorTextField = Color(0xFFC2C2C2);
const kDarkWhite = Color(0xFFF1F7F7);
const kTitleColor = Color(0xFF4A90E2);
const kAlertColor = Color(0xFFFF8919);
const kBgColor = Color(0xFFFAFAFA);
const kHalfDay = Color(0xFFE8B500);
const kGreenColor = Color(0xFF08BC85);

final kTextStyle = GoogleFonts.manrope(
  color: kMainColor,
);
String purchaseCode = '528cdb9a-5d37-4292-a2b5-b792d5eca03a';
const kButtonDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(
    Radius.circular(5),
  ),
);

const TextStyle nameOfTextStyle = TextStyle(
  fontSize: 12,
  color: Colors.redAccent,
  fontWeight: FontWeight.normal,
);
const kInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: kBorderColorTextField),
  filled: true,
  fillColor: Colors.white70,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: kMainColor.withOpacity(0.1)),
  );
}

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

final List<Category> categories = [
  Category(
    id: 4,
    name: "Coiffure",
    image: "images/coiffure.png",
    color: Color(0xFFFD72AF),
    choices: [
      {"choice": "Coupe gratuite", "points": 50, "image": "images/coupe.png"},
      {
        "choice": "Shampoing offert",
        "points": 30,
        "image": "images/shampoing.png"
      },
      {
        "choice": "Réduction de 10%",
        "points": 20,
        "image": "images/reduction.png"
      },
    ],
  ),
  Category(
    id: 3,
    name: "Alimentation",
    image: "images/alimentation.png",
    color: Color(0xFF7C69EE),
    choices: [
      {
        "choice": "Panier de fruits",
        "points": 40,
        "image": "images/fruits.png"
      },
      {
        "choice": "Boisson gratuite",
        "points": 25,
        "image": "images/boisson.png"
      },
    ],
  ),
  Category(
    id: 2,
    name: "Boucherie",
    color: Color(0xFF4ACDF9),
    image: "images/boucherie.png",
    choices: [
      {
        "choice": "Viande hachée 500g",
        "points": 60,
        "image": "images/viande.png"
      },
      {"choice": "Steak offert", "points": 50, "image": "images/steak.png"},
    ],
  ),
  Category(
    id: 1,
    name: "Normale",
    color: Color(0xFFCD3636),
    image: "images/gift.png",
    choices: [
      {"choice": "10 €", "points": 10, "image": "images/10e.png"},
    ],
  ),
  Category(
    id: 5,
    name: "Restauration",
    color: Color(0xFF02B984),
    image: "images/restauration.png",
    choices: [
      {"choice": "Pizza", "points": 40, "image": "images/pizza.png"},
      {"choice": "Burger", "points": 35, "image": "images/burger.png"},
      {"choice": "Sandwich", "points": 30, "image": "images/sandwich.png"},
      {"choice": "Boisson", "points": 20, "image": "images/boisson.png"},
      {"choice": "Tacos", "points": 45, "image": "images/tacos.png"},
      {"choice": "Kebab", "points": 40, "image": "images/kebab.png"},
      {"choice": "Pasta", "points": 50, "image": "images/pasta.png"},
      {"choice": "Salade", "points": 30, "image": "images/salade.png"},
      {"choice": "Crêpe", "points": 25, "image": "images/crepe.png"},
      {"choice": "Glace", "points": 20, "image": "images/glace.png"},
      {"choice": "Café", "points": 15, "image": "images/cafe.png"},
      {"choice": "Smoothie", "points": 20, "image": "images/smoothie.png"},
    ],
  ),
];
