import 'package:flutter/material.dart';
import 'models/place.dart';
import 'services/place_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TASC Travel App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Place>> _placesFuture;
  final TextEditingController _searchController = TextEditingController();
  List<Place> _allPlaces = [];
  List<Place> _filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    _placesFuture = PlaceService.fetchPlaces();
    _placesFuture.then((places) {
      setState(() {
        _allPlaces = places;
        _filteredPlaces = places;
      });
    });
  }

  void _filterPlaces(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPlaces = _allPlaces;
      } else {
        _filteredPlaces = _allPlaces
            .where((place) => place.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Where are you going next?',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _searchController,
                  onChanged: _filterPlaces,
                  decoration: InputDecoration(
                    hintText: 'Search your destination',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Popular Destinations',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  child: FutureBuilder<List<Place>>(
                    future: _placesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: \\${snapshot.error}'));
                      } else if (!_allPlaces.isNotEmpty) {
                        return const Center(child: Text('No destinations found.'));
                      }
                      final places = _filteredPlaces;
                      if (places.isEmpty) {
                        return const Center(child: Text('No destinations found.'));
                      }
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: places.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final place = places[index];
                          return _PlaceCard(place: place);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'FAVORITES'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PROFILE'),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class _HomeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _HomeButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.deepPurple),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  final Place place;
  const _PlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              place.imageUrl,
              height: 100,
              width: 140,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 100,
                width: 140,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, size: 40),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    place.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.favorite_border, color: Colors.red[300]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
