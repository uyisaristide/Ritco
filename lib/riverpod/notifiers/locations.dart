import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ritco_app/models/location.dart';

import '../../constants/_api_utls.dart';

class LocationsNotifier extends StateNotifier<LoactionsState?> {
  LocationsNotifier() : super(LoactionsState.initial());

  final Dio _dio = Dio();

  Future<void> locations(BuildContext context, String district) async {
    try {
      state = state!.copyWith(isLoading: true);
      final response = await _dio.post(
        '${baseUrl}locations/',
        data: {"district": district},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final List<dynamic> myList = response.data['data'];

        state = LoactionsState(
          locations: myList.map((json) => Location.fromJson(json)).toList(),
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
  Future<void>clearLocations()async{
    state = LoactionsState(
      locations: [],
      isLoading: false,
    );
  }
}

class LoactionsState {
  final List<Location> locations;
  final bool isLoading;

  LoactionsState({required this.locations, required this.isLoading});

  factory LoactionsState.initial() =>
      LoactionsState(locations: [], isLoading: false);

  LoactionsState copyWith({List<Location>? orders, bool? isLoading}) {
    return LoactionsState(
      locations: orders ?? this.locations,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
