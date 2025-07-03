class Place {
  final int id;
  final String name;
  final String imageUrl;
  bool isFavorite;

  Place({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
} 