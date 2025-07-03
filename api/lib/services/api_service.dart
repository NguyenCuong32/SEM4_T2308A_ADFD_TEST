import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/place.dart';

class ApiService {
  static Future<List<Place>> getAllPlace() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/places'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Place.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }
}
