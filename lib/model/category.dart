import 'dart:ui';

class Category {
  int id; // Added ID field
  String name;
  String image;
  Color color;
  List<Map<String, dynamic>> choices;

  Category({
    required this.id, // Include ID in the constructor
    required this.name,
    required this.image,
    required this.color,
    required this.choices,
  });

  // Convert Category object to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "color": color.value, // Convert Color to integer
      "choices": choices,
    };
  }

  // Factory constructor to create a Category object from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      color: Color(json["color"]),
      // Convert integer to Color
      choices: List<Map<String, dynamic>>.from(json["choices"]),
    );
  }

  @override
  String toString() {
    return 'Category{id: $id, name: $name, image: $image, color: $color, choices: $choices}';
  }
}
