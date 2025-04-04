
class FavoriteResponse {
  String id;
  String name;
  String url;
  bool liked;
  bool favorite;

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      url: json['url'] ?? "",
      liked: json['liked'] ?? false,
      favorite: json['favorite'] ?? false,
    );
  }

  FavoriteResponse(
      {required this.id,
      required this.name,
      required this.url,
      required this.liked,
      required this.favorite});

  UiFavorite toUIType() {
    return UiFavorite(
        id: id, name: name, url: url, favorite: favorite, liked: liked);
  }
}

class UiFavorite {
  String id;
  String name;
  String url;
  bool liked;
  bool favorite;

  UiFavorite(
      {required this.id,
      required this.name,
      required this.url,
      required this.favorite,
      required this.liked});
}
