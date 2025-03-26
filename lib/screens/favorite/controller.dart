import 'package:get/get.dart';
import 'package:sample/models/response/favorite.dart';
import 'package:sample/services/api_service.dart';
import 'package:sample/utils/overlay.dart';

class FavoriteController extends GetxController {
  final _favorites = <UiFavorite>[].obs;
  List<UiFavorite> get favorites => _favorites;

  @override
  void onReady() {
    super.onReady();
    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    // send sample data
    _favorites.value = [
      FavoriteResponse(name: 'VODKA', url: 'vodka'),
      FavoriteResponse(name: 'COGNAC', url: 'cognac'),
    ].map((e) => e.toUIType()).toList();
    update(['list']);
    return;
    try {
      final response = await Get.find<ApiService>().getFavorites();
      _favorites.value = response.map((e) => e.toUIType()).toList();
    } catch (e) {
      print(e);
      Get.error('Categories', 'Error fetching categories');
    }
  }
}
