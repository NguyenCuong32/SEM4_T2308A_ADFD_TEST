import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/place.dart';
import '../services/place_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Place>> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = PlaceService.getAllPlaces();
  }

  // ✅ Hàm xử lý lỗi font tiếng Việt (encoding sai)
  String fixEncoding(String text) {
    try {
      return const Utf8Decoder().convert(text.runes.toList());
    } catch (e) {
      return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hi Guy!")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildSearchBox(),
            SizedBox(height: 10),
            _buildMenuRow(),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Popular Destinations", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            Expanded(child: _buildPlaceList())
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search your destination',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildMenuRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildMenuItem(Icons.hotel, 'Hotels'),
        _buildMenuItem(Icons.flight, 'Flights'),
        _buildMenuItem(Icons.all_inclusive, 'All'),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          child: Icon(icon),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }

  Widget _buildPlaceList() {
    return FutureBuilder<List<Place>>(
      future: _placesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(child: Text("Failed to load"));

        final places = snapshot.data!;
        return GridView.builder(
          itemCount: places.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            final place = places[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(
                            place.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                fixEncoding(place.name),
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Text('${place.rating}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.favorite, color: place.isFavorite ? Colors.red : Colors.grey),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
