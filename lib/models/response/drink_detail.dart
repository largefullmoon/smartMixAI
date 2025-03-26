import 'dart:math';

class DrinkDetailResponse {
  String name;
  String url;

  DrinkDetailResponse({required this.name, required this.url});

  UIDrinkDetail toUIType() {
    return UIDrinkDetail(
        id: Random().nextInt(100),
        name: name,
        url: url,
        incredients: [
          Tuple2('50ml', '50ml Rhum'),
          Tuple2('20ml', '20ml Jus de citron vert')
        ],
        instructions: [
          Tuple2('mel', 'Mélanger.'),
          Tuple2('ser', 'Servir frais.')
        ],
        rating: 5,
        reviews: 32,
        description: 'A refreshing drink'
        // Add appropriate description
        );
  }
}

class UIDrinkDetail {
  int id;
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
