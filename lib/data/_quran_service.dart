import 'dart:convert';
import 'package:http/http.dart' as http;

class SurahListService {
  static Future<Map<String, dynamic>> fetchQuranData() async {
    try {
      final response = await http
          .get(Uri.parse("https://api.alquran.cloud/v1/quran/quran-uthmani"));
      if (response.statusCode == 200) {
        final String jsonString = response.body;
        return json.decode(jsonString);
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error loading data: $e");
    }
  }
}

class SurahArabicX {
  static Future<Map<String, dynamic>> fetchQuranData(int index) async {
    try {
      final response = await http
          .get(Uri.parse("https://api.alquran.cloud/v1/quran/quran-uthmani"));
      if (response.statusCode == 200) {
        final String jsonString = response.body;
        return json.decode(jsonString)["data"]["surahs"][index];
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error loading data: $e");
    }
  }
}

class SurahEnglishTranslateService {
  static Future<Map<String, dynamic>> fetchQuranData(int index) async {
    try {
      final response = await http
          .get(Uri.parse("https://api.alquran.cloud/v1/quran/en.asad"));
      if (response.statusCode == 200) {
        final String jsonString = response.body;
        return json.decode(jsonString)["data"]["surahs"][index];
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error loading data: $e");
    }
  }
}

class SurahAudioService {
  static Future<Map<String, dynamic>> fetchQuranData(int index) async {
    try {
      final response = await http
          .get(Uri.parse("https://api.alquran.cloud/v1/quran/ar.alafasy"));
      if (response.statusCode == 200) {
        final String jsonString = response.body;
        return json.decode(jsonString)["data"]["surahs"][index];
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error loading data: $e");
    }
  }
}

class SurahEnglishTransliterationService {
  static Future<Map<String, dynamic>> fetchQuranData(int index) async {
    try {
      final response = await http.get(
          Uri.parse("https://api.alquran.cloud/v1/quran/en.transliteration"));
      if (response.statusCode == 200) {
        final String jsonString = response.body;
        return json.decode(jsonString)["data"]["surahs"][index];
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error loading data: $e");
    }
  }
}

class AllSurahList{
  static Future<Map<String, dynamic>> fetchQuranData() async {
    try {
      final response = await http
          .get(Uri.parse("http://api.alquran.cloud/v1/surah"));
      if (response.statusCode == 200) {
        final String jsonString = response.body;
        return json.decode(jsonString);
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error loading data: $e");
    }
  }
}