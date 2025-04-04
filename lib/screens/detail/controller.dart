import 'package:get/get.dart';
import 'package:sample/models/response/drink_detail.dart';
import 'package:sample/models/response/favorite.dart';
import 'package:sample/services/api_service.dart';
import 'package:sample/utils/overlay.dart';

class DrinkDetailController extends GetxController {
  final _detail = Rx<UIDrinkDetail?>(null);
  UIDrinkDetail? get detail => _detail.value;

  final loading = false.obs;


  Future<void> fetchProduct(String id) async {
    // send sample data
    // _detail.value = DrinkDetailResponse(name: 'name', url: 'url').toUIType();
    // update(['detail']);
    // return;
    try {
      loading.value = true;
      update(["detail"]);
      final response = await Get.find<ApiService>().getProduct(id);
      if (response != null)
      _detail.value = response.toUIType();
      print(detail!.incredients);
      
    } catch (e) {
      print(e);
      Get.error('Categories', 'Error fetching categories');
    }
    loading.value = false;
    update(["detail"]);
  }
}
