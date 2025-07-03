import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/place.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8080';

  static Future<List<Place>> getAllPlaces() async {
    final response = await http.get(Uri.parse('$baseUrl/api/places'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Place.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }
}
