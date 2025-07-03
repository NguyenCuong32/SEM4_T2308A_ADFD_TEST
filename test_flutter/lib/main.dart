import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Place {
  final int id;
  final String name;
  final String description;

  Place({required this.id, required this.name, required this.description});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Place> _places = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchPlaces();
  }

  Future<void> fetchPlaces() async {
    final response =
    await http.get(Uri.parse('http://localhost:9191/api/places'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        _places = jsonData.map((item) => Place.fromJson(item)).toList();
        _loading = false;
      });
    } else {
      throw Exception('Failed to load places');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: const Color(0xFFF5F5F5), // Nền nhẹ
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: _places.length,
          itemBuilder: (context, index) {
            final place = _places[index];
            return Card(
              elevation: 2,
              margin:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple.shade100,
                  child: Text(
                    place.id.toString(),
                    style: const TextStyle(color: Colors.deepPurple),
                  ),
                ),
                title: Text(
                  place.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  place.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
