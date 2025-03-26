import 'package:get/get.dart';
import 'package:sample/models/response/category.dart';
import 'package:sample/services/api_service.dart';
import 'package:sample/utils/overlay.dart';

class HomeController extends GetxController {
  final _categories = <UiCategory>[].obs;
  List<UiCategory> get categories => _categories;

  final _drinks = <UiCategory>[].obs;
  List<UiCategory> get drinks => _drinks;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchDrinks();
  }

  Future<void> fetchCategories() async {
    // send sample data
    _categories.value = [
      CategoryResponse(name: 'MARGARITA', url: 'cat-1'),
      CategoryResponse(name: 'GIMLET', url: 'cat-2'),
      CategoryResponse(name: 'MANHATTAN', url: 'cat-3'),
    ].map((e) => e.toUIType()).toList();
    return;
    try {
      final response = await Get.find<ApiService>().getCategories();
      _categories.value = response.map((e) => e.toUIType()).toList();
    } catch (e) {
      print(e);
      Get.error('Categories', 'Error fetching categories');
    }
  }

  Future<void> fetchDrinks() async {
    // send sample data
    _drinks.value = [
      CategoryResponse(name: 'MARGARITA', url: 'cat-1'),
      CategoryResponse(name: 'GIMLET', url: 'cat-2'),
      CategoryResponse(name: 'MANHATTAN', url: 'cat-3'),
      CategoryResponse(name: 'MANHATTAN', url: 'cat-3'),
      CategoryResponse(name: 'MANHATTAN', url: 'cat-3'),
      CategoryResponse(name: 'MANHATTAN', url: 'cat-3'),
    ].map((e) => e.toUIType()).toList();
    return;
    try {
      final response = await Get.find<ApiService>().getCategories();
      _drinks.value = response.map((e) => e.toUIType()).toList();
    } catch (e) {
      print(e);
      Get.error('Categories', 'Error fetching categories');
    }
  }

  void addToFavorite(UiCategory category) {
    if (!_categories.contains(category)) {
      _categories.add(category);
    }
  }
}
