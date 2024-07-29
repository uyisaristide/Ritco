import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ritco_app/models/location.dart';
import 'package:ritco_app/models/schedule.dart';

import '../../constants/_api_utls.dart';

class ScheduleNotifier extends StateNotifier<ScheduleState?> {
  ScheduleNotifier() : super(ScheduleState.initial());

  final Dio _dio = Dio();

  Future<void> schedules(BuildContext context, json) async {
    try {
      state = state!.copyWith(isLoading: true);
      final response = await _dio.post(
        '${baseUrl}schedules/',
        data: {
          "departure": "2", // Location id
          "destination": "1" // location id
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final List<dynamic> myList = response.data['data'];

        state = ScheduleState(
          locations: myList.map((json) => Schedule.fromJson(json)).toList(),
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

  Future<void> clearSchedules() async {
    state = ScheduleState(
      locations: [],
      isLoading: false,
    );
  }
}

class ScheduleState {
  final List<Schedule> locations;
  final bool isLoading;

  ScheduleState({required this.locations, required this.isLoading});

  factory ScheduleState.initial() =>
      ScheduleState(locations: [], isLoading: false);

  ScheduleState copyWith({List<Schedule>? orders, bool? isLoading}) {
    return ScheduleState(
      locations: orders ?? this.locations,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
