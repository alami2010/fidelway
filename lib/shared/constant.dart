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
    id: 1,
    name: "Autre",
    color: Color(0xFFCD3636),
    image: "images/gift.png",
    choices: [
      {"choice": "10 €", "points": 10, "image": "images/10e.png"},
      {"choice": "Réduction de 10%", "points": 20, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 2,
    name: "Boucherie",
    color: Color(0xFF4ACDF9),
    image: "images/boucherie.png",
    choices: [
      {"choice": "Viande hachée 500g", "points": 60, "image": "images/viande.png"},
      {"choice": "Steak offert", "points": 50, "image": "images/steak.png"},
      {"choice": "10 €", "points": 10, "image": "images/10e.png"},
      {"choice": "Réduction de 10%", "points": 20, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 3,
    name: "Alimentation Generale",
    image: "images/alimentation.png",
    color: Color(0xFF7C69EE),
    choices: [
      {"choice": "Panier de fruits", "points": 40, "image": "images/fruits.png"},
      {"choice": "Boisson gratuite", "points": 25, "image": "images/boisson.png"},
      {"choice": "10 €", "points": 10, "image": "images/10e.png"},
      {"choice": "Réduction de 10%", "points": 20, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 4,
    name: "Coiffeur pour homme",
    image: "images/coiffure.png",
    color: Color(0xFFFD72AF),
    choices: [
      {"choice": "Coupe gratuite", "points": 50, "image": "images/coupe.png"},
      {"choice": "Shampoing offert", "points": 30, "image": "images/shampoing.png"},
      {"choice": "Barbe", "points": 30, "image": "images/barbe.png"},
      {"choice": "Réduction de 10%", "points": 20, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 5,
    name: "Coiffeur pour femme",
    image: "images/coiffeurFemme.png",
    color: Color(0xFFFD72AF),
    choices: [
      {"choice": "Coupe offerte", "points": 50, "image": "images/coupeFemme.png"},
      {"choice": "Shampoing offert", "points": 30, "image": "images/shampoing.png"},
      {"choice": "Sechoir", "points": 30, "image": "images/sechoir.png"},
      {"choice": "Broching", "points": 40, "image": "images/broching.png"},
      {"choice": "Shampoing", "points": 40, "image": "images/shampoing.png"},
      {"choice": "Réduction de 10%", "points": 20, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 6,
    name: "Boulangerie",
    color: Color(0xFF02B984),
    image: "images/boulangerie.png",
    choices: [
      {"choice": "Baguette", "points": 40, "image": "images/baguette.png"},
      {"choice": "Tradition", "points": 35, "image": "images/tradition.png"},
      {"choice": "Croissant", "points": 30, "image": "images/croissant.png"},
      {"choice": "Pain au chocolat", "points": 20, "image": "images/painchocolat.png"},
      {"choice": "Cookies", "points": 20, "image": "images/cookies.png"},
      {"choice": "10 €", "points": 10, "image": "images/10e.png"},
      {"choice": "Réduction de 10%", "points": 20, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 7,
    name: "Centre de beauté",
    color: Color(0xFF02B984),
    image: "images/centreBeaute.png",
    choices: [
      {"choice": "Epilation", "points": 40, "image": "images/epilation.png"},
      {"choice": "Manicure", "points": 35, "image": "images/manicure.png"},
      {"choice": "Pedicure", "points": 30, "image": "images/pedicure.png"},
      {"choice": "10 €", "points": 10, "image": "images/10e.png"},
      {"choice": "Réduction de 10%", "points": 20, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 8,
    name: "Garagiste Auto",
    color: Color(0xFF02B984),
    image: "images/garagiste.png",
    choices: [
      {"choice": "Diagnostique", "points": 40, "image": "images/diagnostique.png"},
      {"choice": "Vidange", "points": 35, "image": "images/vidange.png"},
      {"choice": "10 €", "points": 10, "image": "images/10e.png"},
      {"choice": "Réduction de 10%", "points": 20, "image": "images/reduction.png"},
    ],
  ),
];
