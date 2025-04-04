class Parking {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final int totalSpots;
  final int availableSpots;
  final double pricePerHour;
  final String imageUrl;
  final bool isOpen;
  final List<String> services;
  final double rating;

  Parking({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.totalSpots,
    required this.availableSpots,
    required this.pricePerHour,
    required this.imageUrl,
    required this.isOpen,
    required this.services,
    required this.rating,
  });

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      totalSpots: json['totalSpots'],
      availableSpots: json['availableSpots'],
      pricePerHour: json['pricePerHour'].toDouble(),
      imageUrl: json['imageUrl'],
      isOpen: json['isOpen'],
      services: List<String>.from(json['services']),
      rating: json['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'totalSpots': totalSpots,
      'availableSpots': availableSpots,
      'pricePerHour': pricePerHour,
      'imageUrl': imageUrl,
      'isOpen': isOpen,
      'services': services,
      'rating': rating,
    };
  }
}
