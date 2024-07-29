class Location {
  final String locationId;
  final String name;
  final String district;
  final String createdAt;

  Location({
    required this.locationId,
    required this.name,
    required this.district,
    required this.createdAt,
  });

  // Factory method to create a Location from a JSON object
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locationId: json['location_id'],
      name: json['name'],
      district: json['district'],
      createdAt: json['created_at'],
    );
  }

  // Method to convert a Location object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'location_id': locationId,
      'name': name,
      'district': district,
      'created_at': createdAt,
    };
  }
}
