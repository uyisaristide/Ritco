import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ritco_app/riverpod/notifiers/booking.dart';
import 'package:ritco_app/riverpod/notifiers/districts.dart';
import 'package:ritco_app/riverpod/notifiers/locations.dart';
import 'package:ritco_app/riverpod/notifiers/schedule.dart';
import 'package:ritco_app/riverpod/notifiers/seats.dart';

final districtsProvider =
    StateNotifierProvider<DistrictsNotifier, DistrictsState?>((ref) {
  return DistrictsNotifier();
});
final locationsProvider =
    StateNotifierProvider<LocationsNotifier, LoactionsState?>((ref) {
  return LocationsNotifier();
});
final destinationProvider =
    StateNotifierProvider<LocationsNotifier, LoactionsState?>((ref) {
  return LocationsNotifier();
});
final schedulesProvider =
    StateNotifierProvider<ScheduleNotifier, ScheduleState?>((ref) {
  return ScheduleNotifier();
});
final seatsProvider = StateNotifierProvider<SeatsNotifier, SeatsState?>((ref) {
  return SeatsNotifier();
});
final bookingProvider =
    StateNotifierProvider<BookingNotifier, BookingsState?>((ref) {
  return BookingNotifier();
});
