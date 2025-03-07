import 'dart:convert';
import 'dart:ui';

class Category {
  int id;
  String name;
  String image;
  Color color;
  List<Map<String, dynamic>> choices;

  Category({
    required this.id,
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
      choices: List<Map<String, dynamic>>.from(json["choices"]),
    );
  }

  // CopyWith method for shallow copy
  Category copyWith({
    int? id,
    String? name,
    String? image,
    Color? color,
    List<Map<String, dynamic>>? choices,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      color: color ?? this.color,
      choices: choices ?? List.from(this.choices), // Create new list instance
    );
  }

  // Deep Copy method
  Category deepCopy() {
    return Category.fromJson(jsonDecode(jsonEncode(this.toJson())));
  }

  @override
  String toString() {
    return 'Category{id: $id, name: $name, image: $image, color: $color, choices: $choices}';
  }
}

