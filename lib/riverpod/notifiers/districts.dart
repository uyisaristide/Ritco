import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ritco_app/models/districts.dart';

import '../../constants/_api_utls.dart';
import '../../utls/api_related.dart';

class DistrictsNotifier extends StateNotifier<DistrictsState?> {
  DistrictsNotifier() : super(DistrictsState.initial());

  final Dio _dio = Dio();

  Future<void> districts(BuildContext context) async {
    try {
      state = state!.copyWith(isLoading: true);
      final response = await _dio.get(
        '${baseUrl}locations/districts',
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final List<dynamic> myList = response.data['data'];

        state = DistrictsState(
          orders: myList.map((json) => Location.fromJson(json)).toList(),
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

class DistrictsState {
  final List<Location> orders;
  final bool isLoading;

  DistrictsState({required this.orders, required this.isLoading});

  factory DistrictsState.initial() => DistrictsState(orders: [], isLoading: false);

  DistrictsState copyWith({List<Location>? orders, bool? isLoading}) {
    return DistrictsState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
