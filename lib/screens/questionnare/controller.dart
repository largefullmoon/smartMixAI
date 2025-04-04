import 'dart:convert';

import 'package:get/get.dart';
import 'package:sample/common/service/shared_prefs.dart';
import 'package:sample/services/score_service.dart';
import 'package:sample/utils/overlay.dart';

class QuestionnaireController extends GetxController {
  final ScoreService _service = ScoreService();
  SharedPrefsService sharedPrefsService = Get.find<SharedPrefsService>();
  Future<void> saveScore(Map<int, int> scoreData) async {
    try {
      await _service.saveScore(scoreData);
      await sharedPrefsService.setString(
          'scores',
          jsonEncode(
              scoreData.map((key, value) => MapEntry(key.toString(), value))));
      
      Get.success('Score', 'Score saved successfully');

    } catch (e) {
      print(e);
      Get.error('Score', 'Error saving');
    }
  }

  Future<String?> getScore() async {
    try {
      var res = sharedPrefsService.getString('scores');
      print(res);
      return res;
    } catch (e) {
      print(e);
      Get.error('Score', 'Error saving');
    }
    return null;
  }
}
