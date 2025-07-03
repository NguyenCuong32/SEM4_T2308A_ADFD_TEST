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
  List<Place> _allPlaces = [];
  String _searchText = '';
  int _selectedIndex = 0; // 0: Home, 1: Favorites

  @override
  void initState() {
    super.initState();
    _placesFuture = PlaceService.fetchPlaces().then((places) {
      _allPlaces = places;
      return places;
    });
  }

  List<Place> _filterPlaces() {
    if (_searchText.isEmpty) return _allPlaces;
    return _allPlaces
        .where((place) =>
            place.name.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  List<Place> _favoritePlaces() {
    return _allPlaces.where((place) => place.isFavorite).toList();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFavoriteChanged() {
    setState(() {}); // Để cập nhật UI khi favorite thay đổi
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
                  'Hi Guy!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Where are you going next?',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                if (_selectedIndex == 0)
                  TextField(
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
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                  ),
                if (_selectedIndex == 0) const SizedBox(height: 24),
                if (_selectedIndex == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _HomeButton(icon: Icons.hotel, label: 'Hotels'),
                      _HomeButton(icon: Icons.flight, label: 'Flights'),
                      _HomeButton(icon: Icons.apps, label: 'All'),
                    ],
                  ),
                const SizedBox(height: 32),
                Text(
                  _selectedIndex == 0 ? 'Popular Destinations' : 'Favorites',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No destinations found.'));
                      }
                      if (_allPlaces.isEmpty) {
                        _allPlaces = snapshot.data!;
                      }
                      final places = _selectedIndex == 0
                          ? _filterPlaces()
                          : _favoritePlaces();
                      if (places.isEmpty) {
                        return Center(
                            child: Text(_selectedIndex == 0
                                ? 'No destinations match your search.'
                                : 'No favorites yet.'));
                      }
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: places.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final place = places[index];
                          return _PlaceCard(
                            place: place,
                            onFavoriteChanged: _onFavoriteChanged,
                          );
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
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
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

class _PlaceCard extends StatefulWidget {
  final Place place;
  final VoidCallback? onFavoriteChanged;
  const _PlaceCard({required this.place, this.onFavoriteChanged});

  @override
  State<_PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<_PlaceCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.place.isFavorite;
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      widget.place.isFavorite = isFavorite;
      if (widget.onFavoriteChanged != null) {
        widget.onFavoriteChanged!();
      }
    });
  }

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
              widget.place.imageUrl,
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
                    widget.place.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: toggleFavorite,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.red[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
