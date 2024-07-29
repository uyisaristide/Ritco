class Location {
  final String districtId;
  final String provinceId;
  final String districtName;

  Location({
    required this.districtId,
    required this.provinceId,
    required this.districtName,
  });

  // Factory method to create a District from a JSON object
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      districtId: json['district_id'],
      provinceId: json['province_id'],
      districtName: json['district_name'],
    );
  }

  // Method to convert a District object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'district_id': districtId,
      'province_id': provinceId,
      'district_name': districtName,
    };
  }
}
