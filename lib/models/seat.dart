class Seat {
  final String seatId;
  final String scheduleId;
  final String seatNumber;
  final String availability;

  Seat({
    required this.seatId,
    required this.scheduleId,
    required this.seatNumber,
    required this.availability,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      seatId: json['seat_id'],
      scheduleId: json['schedule_id'],
      seatNumber: json['seat_number'],
      availability: json['availability'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seat_id': seatId,
      'schedule_id': scheduleId,
      'seat_number': seatNumber,
      'availability': availability,
    };
  }
}
