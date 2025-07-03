import 'package:flutter/material.dart';
import '../models/place.dart';
import '../services/api_service.dart';
import '../widgets/place_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Place>> futurePlaces;

  @override
  void initState() {
    super.initState();
    futurePlaces = ApiService.getAllPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hi Guy!')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your destination',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Popular Destinations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: FutureBuilder<List<Place>>(
              future: futurePlaces,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data!.map((place) => PlaceCard(place: place)).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
