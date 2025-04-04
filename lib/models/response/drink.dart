import 'dart:math';

import 'package:sample/models/response/category.dart';

class DrinkResponse {
  final String id;
  final String name;
  final String category; // Reference ID
  final Map<String, dynamic> details;
  final List<String> ingredients;
  final bool isFavorite;

  DrinkResponse(
      {required this.id,
      required this.name,
      required this.category,
      required this.details,
      required this.ingredients,
      required this.isFavorite});

  // Factory constructor to create an instance from a JSON map
  factory DrinkResponse.fromJson(Map<String, dynamic> json) {
    return DrinkResponse(
      id: json['id'] ?? '', // MongoDB ID
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      details: Map<String, dynamic>.from(json['details'] ?? {}),
      ingredients: List<String>.from(json['ingredients'] ?? []),
      isFavorite: json['isFavorite'] ?? false,

    );
  }

  // Convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'details': details,
      'ingredients': ingredients,
    };
  }

  UiDrink toUIType() {
    return UiDrink(
        id: id,
        name: name,
        url: details['image'] ?? "",
        description: details['description'],
        favorite: isFavorite,
        isLiked: false);
  }
}

class UiDrink {
  String id;
  String name;
  String url;
  String description;
  bool favorite;
  bool isLiked;

  UiDrink(
      {required this.id,
      required this.name,
      required this.url,
      required this.description,
      required this.favorite,
      required this.isLiked});
}
