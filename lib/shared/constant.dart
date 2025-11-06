import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

// Free mode configuration flag - Set to true to disable all pricing and payment functionality
const bool isAppFree = true;

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

List<Category> getCategories(BuildContext context) {
  return [
    Category(
    id: 1,
      name: AppLocalizations.of(context)!.restaurant,
      color: Color(0xFF02B984),
    image: "images/restauration.png",
    choices: [
        {
          "choice": AppLocalizations.of(context)!.pizzaJunior,
          "points": 100,
          "image": "images/pizza1.jpg"
        },
        // ≈10 €
        {
          "choice": AppLocalizations.of(context)!.pizzaSenior,
          "points": 150,
          "image": "images/pizza.png"
        },
        // ≈10 €
        {
          "choice": AppLocalizations.of(context)!.burger,
          "points": 80,
          "image": "images/burger.png"
        }, // ≈8 €
        {
          "choice": AppLocalizations.of(context)!.sandwich,
          "points": 60,
          "image": "images/sandwich.png"
        }, // ≈6 €
        {
          "choice": AppLocalizations.of(context)!.drink,
          "points": 30,
          "image": "images/boisson.png"
        }, // ≈3 €
        {
          "choice": AppLocalizations.of(context)!.tacos,
          "points": 90,
          "image": "images/tacos.png"
        }, // ≈9 €
        {
          "choice": AppLocalizations.of(context)!.kebab,
          "points": 80,
          "image": "images/kebab.png"
        }, // ≈8 €
        {
          "choice": AppLocalizations.of(context)!.pasta,
          "points": 100,
          "image": "images/pasta.png"
        }, // ≈10 €
        {
          "choice": AppLocalizations.of(context)!.salad,
          "points": 60,
          "image": "images/salade.png"
        }, // ≈6 €
        {
          "choice": AppLocalizations.of(context)!.crepe,
          "points": 50,
          "image": "images/crepe.png"
        }, // ≈5 €
        {
          "choice": AppLocalizations.of(context)!.iceCream,
          "points": 40,
          "image": "images/glace.png"
        }, // ≈4 €
        {
          "choice": AppLocalizations.of(context)!.coffee,
          "points": 20,
          "image": "images/cafe.png"
        }, // ≈2 €
        {
          "choice": AppLocalizations.of(context)!.smoothie,
          "points": 50,
          "image": "images/smoothie.png"
        }, // ≈5 €
      ],
  ),
  Category(
    id: 2,
      name: AppLocalizations.of(context)!.butcher,
      color: Color(0xFF4ACDF9),
    image: "images/boucherie.png",
    choices: [
        {
          "choice": AppLocalizations.of(context)!.groundMeat500g,
          "points": 60,
          "image": "images/viande.png"
        }, // ≈6 €
        {
          "choice": AppLocalizations.of(context)!.freeSteak,
          "points": 100,
          "image": "images/steak.png"
        }, // ≈10 €
        {
          "choice": AppLocalizations.of(context)!.tenEuro,
          "points": 100,
          "image": "images/10e.png"
        },
        {
          "choice": AppLocalizations.of(context)!.tenPercentDiscount,
          "points": 100,
          "image": "images/reduction.png"
        },
      ],
  ),
  Category(
    id: 3,
      name: AppLocalizations.of(context)!.generalFood,
      image: "images/alimentation.png",
    color: Color(0xFF7C69EE),
    choices: [
        {
          "choice": AppLocalizations.of(context)!.fruitBasket,
          "points": 80,
          "image": "images/fruits.png"
        }, // ≈8 €
        {
          "choice": AppLocalizations.of(context)!.freeDrink,
          "points": 30,
          "image": "images/boisson.png"
        }, // ≈3 €
        {
          "choice": AppLocalizations.of(context)!.tenEuro,
          "points": 100,
          "image": "images/10e.png"
        },
        {
          "choice": AppLocalizations.of(context)!.tenPercentDiscount,
          "points": 100,
          "image": "images/reduction.png"
        },
      ],
  ),
  Category(
    id: 4,
      name: AppLocalizations.of(context)!.menHairdresser,
      image: "images/coiffure.png",
    color: Color(0xFFFD72AF),
    choices: [
        {
          "choice": AppLocalizations.of(context)!.freeHaircut,
          "points": 100,
          "image": "images/coupe.png"
        }, // ≈10 €
        {
          "choice": AppLocalizations.of(context)!.freeShampoo,
          "points": 50,
          "image": "images/shampoing.png"
        }, // ≈5 €
        {
          "choice": AppLocalizations.of(context)!.beard,
          "points": 50,
          "image": "images/barbe.png"
        }, // ≈5 €
        {
          "choice": AppLocalizations.of(context)!.tenPercentDiscount,
          "points": 100,
          "image": "images/reduction.png"
        },
      ],
  ),
  Category(
    id: 5,
      name: AppLocalizations.of(context)!.womenHairdresser,
      image: "images/coiffeurFemme.png",
    color: Color(0xFFFD72AF),
    choices: [
        {
          "choice": AppLocalizations.of(context)!.freeCut,
          "points": 100,
          "image": "images/coupeFemme.png"
        }, // ≈10 €
        {
          "choice": AppLocalizations.of(context)!.freeShampoo,
          "points": 50,
          "image": "images/shampoing.png"
        }, // ≈5 €
        {
          "choice": AppLocalizations.of(context)!.hairDryer,
          "points": 40,
          "image": "images/sechoir.png"
        }, // ≈4 €
        {
          "choice": AppLocalizations.of(context)!.blowDry,
          "points": 60,
          "image": "images/broching.png"
        }, // ≈6 €
        {
          "choice": AppLocalizations.of(context)!.freeShampoo,
          "points": 50,
          "image": "images/shampoing.png"
        }, // ≈5 €
        {
          "choice": AppLocalizations.of(context)!.tenPercentDiscount,
          "points": 100,
          "image": "images/reduction.png"
        },
      ],
  ),
  Category(
    id: 6,
      name: AppLocalizations.of(context)!.bakery,
      color: Color(0xFF02B984),
    image: "images/boulangerie.png",
    choices: [
        {
          "choice": AppLocalizations.of(context)!.baguette,
          "points": 20,
          "image": "images/baguette.png"
        }, // ≈2 €
        {
          "choice": AppLocalizations.of(context)!.traditional,
          "points": 30,
          "image": "images/tradition.png"
        }, // ≈3 €
        {
          "choice": AppLocalizations.of(context)!.croissant,
          "points": 20,
          "image": "images/croissant.png"
        }, // ≈2 €
        {
          "choice": AppLocalizations.of(context)!.chocolateBread,
          "points": 20,
          "image": "images/painchocolat.png"
        }, // ≈2 €
        {
          "choice": AppLocalizations.of(context)!.cookies,
          "points": 20,
          "image": "images/cookies.png"
        }, // ≈2 €
        {
          "choice": AppLocalizations.of(context)!.tenEuro,
          "points": 100,
          "image": "images/10e.png"
        },
        {
          "choice": AppLocalizations.of(context)!.tenPercentDiscount,
          "points": 100,
          "image": "images/reduction.png"
        },
      ],
  ),
  Category(
    id: 7,
      name: AppLocalizations.of(context)!.beautyCenter,
      color: Color(0xFF02B984),
    image: "images/centreBeaute.png",
    choices: [
        {
          "choice": AppLocalizations.of(context)!.waxing,
          "points": 80,
          "image": "images/epilation.png"
        }, // ≈8 €
        {
          "choice": AppLocalizations.of(context)!.manicure,
          "points": 70,
          "image": "images/manicure.png"
        }, // ≈7 €
        {
          "choice": AppLocalizations.of(context)!.pedicure,
          "points": 70,
          "image": "images/pedicure.png"
        }, // ≈7 €
        {
          "choice": AppLocalizations.of(context)!.tenEuro,
          "points": 100,
          "image": "images/10e.png"
        },
        {
          "choice": AppLocalizations.of(context)!.tenPercentDiscount,
          "points": 100,
          "image": "images/reduction.png"
        },
      ],
  ),
  Category(
    id: 8,
      name: AppLocalizations.of(context)!.autoMechanic,
      color: Color(0xFF02B984),
    image: "images/garagiste.png",
    choices: [
        {
          "choice": AppLocalizations.of(context)!.diagnosis,
          "points": 100,
          "image": "images/diagnostique.png"
        }, // ≈10 €
        {
          "choice": AppLocalizations.of(context)!.oilChange,
          "points": 120,
          "image": "images/vidange.png"
        }, // ≈12 €
        {
          "choice": AppLocalizations.of(context)!.tenEuro,
          "points": 100,
          "image": "images/10e.png"
        },
        {
          "choice": AppLocalizations.of(context)!.tenPercentDiscount,
          "points": 100,
          "image": "images/reduction.png"
        },
      ],
  ),
  Category(
    id: 9,
      name: AppLocalizations.of(context)!.other,
      color: Color(0xFFCD3636),
    image: "images/gift.png",
    choices: [
        {
          "choice": AppLocalizations.of(context)!.tenEuro,
          "points": 100,
          "image": "images/10e.png"
        },
        {
          "choice": AppLocalizations.of(context)!.tenPercentDiscount,
          "points": 100,
          "image": "images/reduction.png"
        },
      ],
  ),
];
}