import 'dart:convert';
import 'package:http/http.dart' as http;

class Search {
  static Future<List<Map<String, dynamic>>> getSearchResult(
      var userText) async {
    try {
      final response =
          await http.get(Uri.parse("https://api.alquran.cloud/v1/surah"));
      if (response.statusCode == 200) {
        final String jsonString = response.body;
        final map = json.decode(jsonString);
        List<Map<String, dynamic>> results = [];

        for (var individualData in map['data']) {
          if (individualData['englishName'].toString().toLowerCase() ==
                  userText.toString().toLowerCase() ||
              individualData['englishName']
                  .toString()
                  .toLowerCase()
                  .contains(userText.toString().toLowerCase())) {
            results.add({
              "response": "success",
              "number": individualData['number'].toString(),
              "arabicName": individualData['name'],
              "englishName": individualData['englishName'],
              "numberOfAyahs": individualData['numberOfAyahs'].toString(),
              "revelationType": individualData['revelationType'],
            });
          }
        }

        if (results.isNotEmpty) {
          return results;
        } else {
          return [
            {
              "response": "failed",
            }
          ];
        }
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error loading data: $e");
    }
  }
}
