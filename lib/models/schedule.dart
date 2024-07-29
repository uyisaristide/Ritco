class Schedule {
  final String scheduleId;
  final String? busId;
  final String departureTime;
  final String arrivalTime;
  final String createdAt;
  final String departure;
  final String destination;
  final String fare;

  Schedule({
    required this.scheduleId,
    required this.busId,
    required this.departureTime,
    required this.arrivalTime,
    required this.createdAt,
    required this.departure,
    required this.destination,
    required this.fare,
  });

  // Factory method to create a Schedule from a JSON object
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      scheduleId: json['schedule_id'],
      busId: json['bus_id']??'',
      departureTime: json['departure_time'],
      arrivalTime: json['arrival_time'],
      createdAt: json['created_at'],
      departure: json['departure'],
      destination: json['destination'],
      fare: json['fare'],
    );
  }

  // Method to convert a Schedule object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'schedule_id': scheduleId,
      'bus_id': busId,
      'departure_time': departureTime,
      'arrival_time': arrivalTime,
      'created_at': createdAt,
      'departure': departure,
      'destination': destination,
      'fare': fare,
    };
  }
}
