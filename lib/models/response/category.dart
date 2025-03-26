import 'dart:math';

class CategoryResponse{
  String name;
  String url;

  CategoryResponse({
    required this.name,
    required this.url
  });

  UiCategory toUIType() {
    return UiCategory(id: Random().nextInt(100), name: name, url: url);
  }
}

class UiCategory {
  int id;
  String name;
  String url;

  UiCategory({required this.id, required this.name, required this.url});
}
