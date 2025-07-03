import 'dart:convert';
import 'package:http/http.dart' as http;
import 'place.dart';

class ApiService {
  // Địa chỉ này phải đúng với backend của bạn!
  static const String apiUrl = 'http://localhost:8080/api/places';

  static Future<List<Place>> fetchPlaces() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Place.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }
}
