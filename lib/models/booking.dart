class Booking {
  String bookingId;
  String userId;
  String scheduleId;
  String bookingStatus;
  String paymentStatus;
  DateTime bookingDate;
  dynamic busId;
  String routeId;
  DateTime departureTime;
  DateTime arrivalTime;
  DateTime createdAt;
  dynamic parentId;
  String departure;
  String destination;
  String fare;
  List<String> seats;

  Booking({
    required this.bookingId,
    required this.userId,
    required this.scheduleId,
    required this.bookingStatus,
    required this.paymentStatus,
    required this.bookingDate,
    this.busId,
    required this.routeId,
    required this.departureTime,
    required this.arrivalTime,
    required this.createdAt,
    this.parentId,
    required this.departure,
    required this.destination,
    required this.fare,
    required this.seats,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingId: json['booking_id'],
      userId: json['user_id'],
      scheduleId: json['schedule_id'],
      bookingStatus: json['booking_status'],
      paymentStatus: json['payment_status'],
      bookingDate: DateTime.parse(json['booking_date']),
      busId: json['bus_id'],
      routeId: json['route_id'],
      departureTime: DateTime.parse(json['departure_time']),
      arrivalTime: DateTime.parse(json['arrival_time']),
      createdAt: DateTime.parse(json['created_at']),
      parentId: json['parent_id'],
      departure: json['departure'],
      destination: json['destination'],
      fare: json['fare'],
      seats: List<String>.from(json['seats']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'user_id': userId,
      'schedule_id': scheduleId,
      'booking_status': bookingStatus,
      'payment_status': paymentStatus,
      'booking_date': bookingDate.toIso8601String(),
      'bus_id': busId,
      'route_id': routeId,
      'departure_time': departureTime.toIso8601String(),
      'arrival_time': arrivalTime.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'parent_id': parentId,
      'departure': departure,
      'destination': destination,
      'fare': fare,
      'seats': List<dynamic>.from(seats.map((x) => x)),
    };
  }
}
