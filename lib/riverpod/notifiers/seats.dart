import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ritco_app/models/location.dart';
import 'package:ritco_app/models/schedule.dart';

import '../../constants/_api_utls.dart';
import '../../models/seat.dart';

class SeatsNotifier extends StateNotifier<SeatsState?> {
  SeatsNotifier() : super(SeatsState.initial());

  final Dio _dio = Dio();

  Future<void> seats(BuildContext context, json) async {
    try {
      state = state!.copyWith(isLoading: true);
      final response = await _dio.post(
        '${baseUrl}booking/checkSeats',
        data:{
          "schedule_id":1
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final List<dynamic> myList = response.data['data'];

        state = SeatsState(
          locations: myList.map((json) => Seat.fromJson(json)).toList(),
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
}

class SeatsState {
  final List<Seat> locations;
  final bool isLoading;

  SeatsState({required this.locations, required this.isLoading});

  factory SeatsState.initial() =>
      SeatsState(locations: [], isLoading: false);

  SeatsState copyWith({List<Seat>? orders, bool? isLoading}) {
    return SeatsState(
      locations: orders ?? this.locations,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
