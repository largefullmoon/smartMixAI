import 'dart:math';

class DrinkDetailResponse {
  final String id;
  final String name;
  final String category; // Reference ID
  final Map<String, dynamic> details;
  final List<String> ingredients;

  DrinkDetailResponse(
      {required this.id,
      required this.name,
      required this.category,
      required this.details,
      required this.ingredients});

  // Factory constructor to create an instance from a JSON map
  factory DrinkDetailResponse.fromJson(Map<String, dynamic> json) {
    print(json['ingredients']);
    return DrinkDetailResponse(
      id: json['id'] ?? '', // MongoDB ID
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      details: Map<String, dynamic>.from(json['details'] ?? {}),
      ingredients: List<String>.from(json['ingredients'] ?? []),
    );
  }

  // Convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'category': category,
      'details': details,
      'ingredients': ingredients,
    };
  }

  UIDrinkDetail toUIType() {
    return UIDrinkDetail(
        id: id,
        name: name,
        url: details['image'] ?? "",
        incredients: ingredients.map((e) => Tuple2('50ml', e)).toList(),
        //  [
        //   Tuple2('50ml', '50ml Rhum'),
        //   Tuple2('20ml', '20ml Jus de citron vert')
        // ],
        instructions: [
          Tuple2('mel', 'Mélanger.'),
          Tuple2('ser', 'Servir frais.')
        ],
        rating: 5,
        reviews: 32,
        description: details['description'] ?? ""
        // Add appropriate description
        );
  }
}

class UIDrinkDetail {
  String id;
  String name;
  String url;
  List<Tuple2<String, String>> incredients;
  List<Tuple2<String, String>> instructions;
  int rating;
  int reviews;
  String description;

  UIDrinkDetail(
      {required this.id,
      required this.name,
      required this.url,
      required this.incredients,
      required this.instructions,
      required this.rating,
      required this.reviews,
      required this.description});
}

class Tuple2<T1, T2> {
  T1 first;
  T2 second;
  Tuple2(this.first, this.second);
}
