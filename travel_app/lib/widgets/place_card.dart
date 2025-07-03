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
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(place.image, height: 100, width: 160, fit: BoxFit.cover),
          ),
          const SizedBox(height: 6),
          Text(place.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
