import 'package:flutter/material.dart';
import '../models/place.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Image.network(
            place.imageUrl,
            width: 160,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5),
          Text(place.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(place.location),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, size: 14, color: Colors.orange),
              Text(place.rating.toString())
            ],
          ),
        ],
      ),
    );
  }
}
