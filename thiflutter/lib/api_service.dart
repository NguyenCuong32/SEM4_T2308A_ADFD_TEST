import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home_page.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/places';

  static Future<List<Place>> getAllPlaces() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((item) => Place(
        name: item['name'],
        imageUrl: item['imageUrl'],
        rating: (item['rating'] as num).toDouble(),
      )).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }
} 