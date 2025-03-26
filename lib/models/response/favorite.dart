import 'dart:math';

class FavoriteResponse {
  String name;
  String url;

  FavoriteResponse({required this.name, required this.url});

  UiFavorite toUIType() {
    return UiFavorite(id: Random().nextInt(100), name: name, url: url);
  }
}

class UiFavorite {
  int id;
  String name;
  String url;

  UiFavorite({required this.id, required this.name, required this.url});
}
