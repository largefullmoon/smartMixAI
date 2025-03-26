import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sample/common/service/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreService extends ApiClient {

  Future<Map<String, dynamic>> saveScore(Map<int, int> scoreData) async {
    // Get the stored email
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString('userEmail') ?? '';

    // Convert the Map<int, int> to a serializable format
    final serializableData = {
      'email': userEmail,
      'scores': scoreData.map((key, value) => MapEntry(key.toString(), value))
    };

    return await postRequest<Map<String, dynamic>>(
      'savescore',
      serializableData
    );
  }

}