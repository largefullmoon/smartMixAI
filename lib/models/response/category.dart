import 'dart:math';

class CategoryResponse{
  String name;
  String url;
  String id;

  CategoryResponse({
    required this.name,
    required this.url, required this.id
  });


  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      name: json['name'] as String,
      url: json['url'] ?? _imageUrl,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url, 'id': id};
  }

  UiCategory toUIType() {
    return UiCategory(id: id, name: name, url: url);
  }
}

class UiCategory {
  String id;
  String name;
  String url;

  UiCategory({required this.id, required this.name, required this.url});
}


var _imageUrl =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGjEIJ36g-UuXq_hk7jdiZkYsqyUBOyptcyA&s";
