import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ritco_app/models/booking.dart';
import 'package:ritco_app/models/location.dart';
import 'package:ritco_app/models/schedule.dart';

import '../../constants/_api_utls.dart';

class BookingNotifier extends StateNotifier<BookingsState?> {
  BookingNotifier() : super(BookingsState.initial());

  final Dio _dio = Dio();

  Future<void> bookings(BuildContext context, String token) async {
    try {
      state = state!.copyWith(isLoading: true);
      final response = await _dio.post(
        '${baseUrl}booking/mybookings',
        data: {
          "token":token
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final List<dynamic> myList = response.data['data'];

        state = BookingsState(
          bookings: myList.map((json) => Booking.fromJson(json)).toList(),
          isLoading: false,
        );

        // Do not throw an exception here, as it disrupts the normal flow
        // throw Exception('Failed to get: ${response.statusMessage}');
      } else {
        throw Exception('Failed to fetch districts: ${response.statusMessage}');
      }
    } catch (e) {
      // Handle error appropriately, e.g., show a snackbar or log the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      state = state!.copyWith(isLoading: false);
    }
  }

  Future<void> bookSeats(BuildContext context, WidgetRef ref, json) async {
    try {
      state = state!.copyWith(isLoading: true);
      final response = await _dio.post(
        '${baseUrl}booking/bookSeats',
        data: json,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${response.data['message']}')),
        );
        context.go('/payment');
      } else {
        throw Exception('Failed to login: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(
            ' Failed to login: ${e.response?.statusCode} ${e.response?.data}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Login failed: ${e.response?.data['message']}')),
        );
      } else {
        print('You Failed to login: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.message}')),
        );
      }
    } catch (e) {
      print('You Failed to login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    } finally {
      state = state!.copyWith(isLoading: false);
    }
  }
}

class BookingsState {
  final List<Booking> bookings;
  final bool isLoading;

  BookingsState({required this.bookings, required this.isLoading});

  factory BookingsState.initial() =>
      BookingsState(bookings: [], isLoading: false);

  BookingsState copyWith({List<Booking>? bookings, bool? isLoading}) {
    return BookingsState(
      bookings: bookings ?? this.bookings,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
