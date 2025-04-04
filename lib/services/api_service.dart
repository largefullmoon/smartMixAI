import 'package:sample/models/response/category.dart';
import 'package:sample/common/service/api_client.dart';
import 'package:sample/models/response/drink.dart';
import 'package:sample/models/response/drink_detail.dart';
import 'package:sample/models/response/favorite.dart';
 
class ApiService extends ApiClient {
  Future<List<CategoryResponse>?> getCategories() async {
    try {
      final response = await getRequest('getcategories');
      print(response);
      if (response['success'] == true) {
        var res = (response['data'] as List)
            .map((e) => CategoryResponse.fromJson(e))
            .toList();
        print(res);
        return res;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<DrinkResponse>?> getDrinks() async {
    try {
      final response = await getRequest('getdrinks');
      print(response);
      if (response['success'] == true) {
        return (response['data'] as List)
            .map((e) => DrinkResponse.fromJson(e))
            .toList();
      }
    } catch (e) {
      print(e);
      // Get.error('Categories', 'Error fetching categories');
    }
    return null;
  }
  
  Future<Map<String, dynamic>> getProfile() async => await getRequest('getprofile');
  Future<Map<String, dynamic>> getSuggestions() async => await getRequest('getsuggestions');
  Future<List<dynamic>> getScore() async => await getRequest('getscore');
  Future<DrinkDetailResponse?> getProduct(String productId) async {
    try {
      final response = await getRequestWithOutAuth('getproduct/$productId');
      print(response);
      if (response['success'] == true) {
        return DrinkDetailResponse.fromJson(response['data']);
      }
    } catch (e) {
      print(e);
      // Get.error('Categories', 'Error fetching categories');
    }
    return null;
  }
  
  Future<List<FavoriteResponse>?> getIngredients() async =>
      await getRequest('getingredients');
  Future<List<FavoriteResponse>?> getFavorites() async {
    try {
      final response = await getRequest('getfavorites');
      print(response);
      if (response['success'] == true) {
        return (response['data'] as List)
            .map((e) => FavoriteResponse.fromJson(e))
            .toList();
      }
    } catch (e) {
      print(e);
      // Get.error('Categories', 'Error fetching categories');
    }
    return null;
  }
  
  Future<List<dynamic>> getHistories() async => await getRequest('gethistories');
  
  Future<String> getResponse(String query, String token) async {
    final response = await postRequest('getresponse', {'query': query});
    return response['response'];
  }

  Future<Map<String, dynamic>> addFavorite(String drinkId) async {
    try {
      final response = await postRequest('addfavorite', {'drinkId': drinkId});
      print(response);
      return response;
    } catch (e) {
      print(e);
      return {'status': 'failed', 'message': 'Error adding favorite'};
    }
  }

  Future<Map<String, dynamic>> likeDrink(String drinkId) async {
    try {
      if (drinkId.isEmpty) {
        return {'status': 'failed', 'message': 'Drink ID is required'};
      }

      final response = await postRequest('like', {'drinkId': drinkId});
      if (response['status'] == 'success') {
        return {'status': 'success', 'message': 'Drink added to liked list'};
      } else {
        return {
          'status': 'failed',
          'message': response['message'] ?? 'Failed to like drink'
        };
      }
    } catch (e) {
      print(e);
      return {'status': 'failed', 'message': 'Server error'};
    }
  }

  Future<Map<String, dynamic>> disLikeDrink(String drinkId) async {
    try {
      if (drinkId.isEmpty) {
        return {'status': 'failed', 'message': 'Drink ID is required'};
      }

      final response = await postRequest('dislike', {'drinkId': drinkId});
      if (response['status'] == 'success') {
        return {'status': 'success', 'message': 'Drink added to liked list'};
      } else {
        return {
          'status': 'failed',
          'message': response['message'] ?? 'Failed to like drink'
        };
      }
    } catch (e) {
      print(e);
      return {'status': 'failed', 'message': 'Server error'};
    }
  }

}
