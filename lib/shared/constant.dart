import 'package:flutter/material.dart';

import '../model/category.dart';

const Color kMainColor = Color(0xFF2979FF); // Refined Teal
const Color kMainColorLight = Color(0xFF66D3CF); // Soft Teal Light
const Color kGreyTextColor = Color(0xFF6E7A8A); // Elegant Slate Grey
const Color kTextColor = Color(0xFF333333); // Deep Charcoal for readability
const Color kBorderColorTextField = Color(0xFFCED4DA); // Subtle Neutral Border
const Color kDarkWhite = Color(0xFFF8F9FA); // Gentle Light Grey-White
const Color kTitleColor = Color(0xFF2563EB); // Professional Blue (slightly deeper)
const Color kAlertColor = Color(0xFFFF7C42); // Modern Warm Orange
const Color kBgColor = Color(0xFFF5F7FA); // Light & Clean Background
const Color kHalfDay = Color(0xFFF4B400); // Rich Gold for attention
const Color kGreenColor = Color(0xFF10B981); // Trendy Emerald Green
const Color kRedColor = Color(0xFFEF4444); // Vivid but Soft Red

const TextStyle kTextStyle = TextStyle(
  fontFamily: 'Poppins',
  color: kTextColor,
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

final List categories = [
  Category(
    id: 1,
    name: "Restauration",
    color: Color(0xFF02B984),
    image: "images/restauration.png",
    choices: [
      {"choice": "Pizza junior", "points": 100, "image": "images/pizza1.jpg"},
      // ≈10 €
      {"choice": "Pizza senior", "points": 150, "image": "images/pizza.png"},
      // ≈10 €
      {"choice": "Burger", "points": 80, "image": "images/burger.png"}, // ≈8 €
      {"choice": "Sandwich", "points": 60, "image": "images/sandwich.png"}, // ≈6 €
      {"choice": "Boisson", "points": 30, "image": "images/boisson.png"}, // ≈3 €
      {"choice": "Tacos", "points": 90, "image": "images/tacos.png"}, // ≈9 €
      {"choice": "Kebab", "points": 80, "image": "images/kebab.png"}, // ≈8 €
      {"choice": "Pasta", "points": 100, "image": "images/pasta.png"}, // ≈10 €
      {"choice": "Salade", "points": 60, "image": "images/salade.png"}, // ≈6 €
      {"choice": "Crêpe", "points": 50, "image": "images/crepe.png"}, // ≈5 €
      {"choice": "Glace", "points": 40, "image": "images/glace.png"}, // ≈4 €
      {"choice": "Café", "points": 20, "image": "images/cafe.png"}, // ≈2 €
      {"choice": "Smoothie", "points": 50, "image": "images/smoothie.png"}, // ≈5 €
    ],
  ),
  Category(
    id: 2,
    name: "Boucherie",
    color: Color(0xFF4ACDF9),
    image: "images/boucherie.png",
    choices: [
      {"choice": "Viande hachée 500g", "points": 60, "image": "images/viande.png"}, // ≈6 €
      {"choice": "Steak offert", "points": 100, "image": "images/steak.png"}, // ≈10 €
      {"choice": "10 €", "points": 100, "image": "images/10e.png"},
      {"choice": "Réduction de 10%", "points": 100, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 3,
    name: "Alimentation Generale",
    image: "images/alimentation.png",
    color: Color(0xFF7C69EE),
    choices: [
      {"choice": "Panier de fruits", "points": 80, "image": "images/fruits.png"}, // ≈8 €
      {"choice": "Boisson gratuite", "points": 30, "image": "images/boisson.png"}, // ≈3 €
      {"choice": "10 €", "points": 100, "image": "images/10e.png"},
      {"choice": "Réduction de 10%", "points": 100, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 4,
    name: "Coiffeur pour homme",
    image: "images/coiffure.png",
    color: Color(0xFFFD72AF),
    choices: [
      {"choice": "Coupe gratuite", "points": 100, "image": "images/coupe.png"}, // ≈10 €
      {"choice": "Shampoing offert", "points": 50, "image": "images/shampoing.png"}, // ≈5 €
      {"choice": "Barbe", "points": 50, "image": "images/barbe.png"}, // ≈5 €
      {"choice": "Réduction de 10%", "points": 100, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 5,
    name: "Coiffeur pour femme",
    image: "images/coiffeurFemme.png",
    color: Color(0xFFFD72AF),
    choices: [
      {"choice": "Coupe offerte", "points": 100, "image": "images/coupeFemme.png"}, // ≈10 €
      {"choice": "Shampoing offert", "points": 50, "image": "images/shampoing.png"}, // ≈5 €
      {"choice": "Sechoir", "points": 40, "image": "images/sechoir.png"}, // ≈4 €
      {"choice": "Broching", "points": 60, "image": "images/broching.png"}, // ≈6 €
      {"choice": "Shampoing", "points": 50, "image": "images/shampoing.png"}, // ≈5 €
      {"choice": "Réduction de 10%", "points": 100, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 6,
    name: "Boulangerie",
    color: Color(0xFF02B984),
    image: "images/boulangerie.png",
    choices: [
      {"choice": "Baguette", "points": 20, "image": "images/baguette.png"}, // ≈2 €
      {"choice": "Tradition", "points": 30, "image": "images/tradition.png"}, // ≈3 €
      {"choice": "Croissant", "points": 20, "image": "images/croissant.png"}, // ≈2 €
      {"choice": "Pain au chocolat", "points": 20, "image": "images/painchocolat.png"}, // ≈2 €
      {"choice": "Cookies", "points": 20, "image": "images/cookies.png"}, // ≈2 €
      {"choice": "10 €", "points": 100, "image": "images/10e.png"},
      {"choice": "Réduction de 10%", "points": 100, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 7,
    name: "Centre de beauté",
    color: Color(0xFF02B984),
    image: "images/centreBeaute.png",
    choices: [
      {"choice": "Epilation", "points": 80, "image": "images/epilation.png"}, // ≈8 €
      {"choice": "Manicure", "points": 70, "image": "images/manicure.png"}, // ≈7 €
      {"choice": "Pedicure", "points": 70, "image": "images/pedicure.png"}, // ≈7 €
      {"choice": "10 €", "points": 100, "image": "images/10e.png"},
      {"choice": "Réduction de 10%", "points": 100, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 8,
    name: "Garagiste Auto",
    color: Color(0xFF02B984),
    image: "images/garagiste.png",
    choices: [
      {"choice": "Diagnostique", "points": 100, "image": "images/diagnostique.png"}, // ≈10 €
      {"choice": "Vidange", "points": 120, "image": "images/vidange.png"}, // ≈12 €
      {"choice": "10 €", "points": 100, "image": "images/10e.png"},
      {"choice": "Réduction de 10%", "points": 100, "image": "images/reduction.png"},
    ],
  ),
  Category(
    id: 9,
    name: "Autre",
    color: Color(0xFFCD3636),
    image: "images/gift.png",
    choices: [
      {"choice": "10 €", "points": 100, "image": "images/10e.png"},
      {"choice": "Réduction de 10%", "points": 100, "image": "images/reduction.png"},
    ],
  ),
];

