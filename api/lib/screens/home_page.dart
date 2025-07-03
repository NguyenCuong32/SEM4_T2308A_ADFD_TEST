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
  List<Place> places = [];

  @override
  void initState() {
    super.initState();
    fetchPlaces();
  }

  void fetchPlaces() async {
    try {
      List<Place> fetched = await ApiService.getAllPlace();
      setState(() {
        places = fetched;
      });
    } catch (e) {
      print('Error loading places: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F0F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hi Guy!\nWhere are you going next?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/147/147144.png',
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),

              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search your destination',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  CategoryButton(icon: Icons.hotel, label: 'Hotels', color: Colors.orange),
                  CategoryButton(icon: Icons.flight, label: 'Flights', color: Colors.pink),
                  CategoryButton(icon: Icons.explore, label: 'All', color: Colors.lightBlue),
                ],
              ),
              const SizedBox(height: 24),

              const Text("Popular Destinations", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              // Horizontal scroll list
              Expanded(
                child: places.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: places.length,
                  itemBuilder: (context, index) =>
                      PlaceCard(place: places[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const CategoryButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 28,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(label),
      ],
    );
  }
}
