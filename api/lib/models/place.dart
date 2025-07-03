class Place {
  final String name;
  final String imageUrl;
  final String location;
  final double rating;

  Place({
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.rating,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      rating: (json['rating'] as num).toDouble(),
    );
  }
}
