import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ritco_app/constants/_assets.dart';
import 'package:ritco_app/riverpod/providers/auth_providers.dart';
import 'package:ritco_app/riverpod/providers/home.dart';

import 'rider.dart';
import 'widgets/cover_container.dart';

class MyTickets extends ConsumerStatefulWidget {
  const MyTickets({super.key});

  @override
  ConsumerState<MyTickets> createState() => _MyTicketsState();
}

class _MyTicketsState extends ConsumerState<MyTickets> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(bookingProvider.notifier)
          .bookings(context, ref.watch(userProvider)!.user!.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    var bookings = ref.watch(bookingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tickets"),
      ),
      body: bookings!.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: List.generate(
                  bookings.bookings.length,
                  (index) {
                    var ticket= bookings.bookings[index];
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        children: [
                          QrImageView(
                            data: 'm${index}n',
                            version: QrVersions.auto,
                            size: 100.0,
                          ),                          // Image.asset(
                          //   AssetsUtils.qr,
                          //   height: 120,
                          // ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  address("Departure: ", ticket.departure),
                                  address("Destination: ", ticket.destination),
                                  address("Time: ", "${ticket.departureTime}"),
                                  // address("Available seats: ", ticket.seats),
                                  address("Fare: ", ticket.fare),
                                ]),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}

