import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:ritco_app/models/schedule.dart';
import 'package:ritco_app/riverpod/providers/auth_providers.dart';
import 'package:ritco_app/riverpod/providers/home.dart';
import 'package:ritco_app/theme/colors.dart';
import 'package:ritco_app/views/home/widgets/cover_container.dart';
import 'package:ritco_app/views/home/widgets/seats_container.dart';

import '../../models/seat.dart';
import '../../utls/styles.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final Schedule schedule;
  const BookingScreen({super.key, required this.schedule});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  List<int> seats = List<int>.generate(55, (i) => i + 1);
  List<int> selectedSeats = [];

  Map<String, dynamic> responseBody = {
    "token": "",
    "schedule_id": '',
    "seats": []
  };

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(seatsProvider.notifier).seats(context, {"schedule_id": 1});
    });

    super.initState();
  }

  bool isSeatAvailable(int seatNumber, List<Seat> apiSeats) {
    final seat = apiSeats.firstWhere(
        (s) => s.seatNumber == seatNumber.toString(),
        orElse: () =>
            Seat(seatId: '', scheduleId: '', seatNumber: '', availability: ''));
    return seat.availability == 'available';
  }

  List<int> getAvailableSeats(List<Seat> apiSeats) {
    return apiSeats
        .where((seat) => seat.availability == 'available')
        .map((seat) => int.parse(seat.seatNumber))
        .toList();
  }

  String buttonText = "Select seats";

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    var apiSeats = ref.watch(seatsProvider);
    List<int> availableSeats = getAvailableSeats(apiSeats!.locations);

    responseBody["token"] = user!.user!.token;
    responseBody["schedule_id"] = widget.schedule.scheduleId;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.schedule.departure} - ${widget.schedule.destination}"),
      ),
      body: Column(
        children: [
          CoverContainer(children: [
            const Text(
              "Seats Mapping",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              width: double.maxFinite,
              color: scaffold,
              child: Container(
                padding: const EdgeInsets.all(1),
                height: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 4)),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                // margin: const EdgeInsets.symmetric(vertical: 1),
                                child: SeatsContainer(
                                    id: 59,
                                    available: isSeatAvailable(
                                        59, apiSeats!.locations))),
                            Row(
                              children: List.generate(
                                13,
                                (index) {
                                  // Calculate the ID starting from 54 and decreasing by 4 for each subsequent seat
                                  int id = 54 - (index * 4);
                                  return SeatsContainer(
                                    id: id,
                                    available: isSeatAvailable(
                                        id, apiSeats!.locations),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Row(
                          children: [
                            Container(
                                child: SeatsContainer(
                                    id: 58,
                                    available: isSeatAvailable(
                                        58, apiSeats!.locations))),
                            Row(
                              children: List.generate(
                                13,
                                    (index) {
                                  // Calculate the ID starting from 54 and decreasing by 4 for each subsequent seat
                                  int id = 53 - (index * 4);
                                  return SeatsContainer(
                                    id: id,
                                    available: isSeatAvailable(
                                        id, apiSeats!.locations),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.symmetric(vertical: 1),
                                child: SeatsContainer(
                                    id: 57,
                                    available: isSeatAvailable(
                                        57, apiSeats!.locations))),
                            Row(
                              children: List.generate(
                                13,
                                (index) => Container(
                                  width: 17.5,
                                  margin: const EdgeInsets.only(right: 3),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                // margin: const EdgeInsets.symmetric(vertical: 1),
                                child: SeatsContainer(
                                    id: 56,
                                    available: isSeatAvailable(
                                        56, apiSeats!.locations))),
                            Row(
                              children: List.generate(
                                13,
                                    (index) {
                                  // Calculate the ID starting from 54 and decreasing by 4 for each subsequent seat
                                  int id = 52 - (index * 4);
                                  return SeatsContainer(
                                    id: id,
                                    available: isSeatAvailable(
                                        id, apiSeats!.locations),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Row(
                          children: [
                            Container(
                                // margin: const EdgeInsets.symmetric(vertical: 1),
                                child: SeatsContainer(
                                    id: 55,
                                    available: isSeatAvailable(
                                        55, apiSeats!.locations))),
                            Row(
                              children: List.generate(
                                13,
                                    (index) {
                                  // Calculate the ID starting from 54 and decreasing by 4 for each subsequent seat
                                  int id = 51 - (index * 4);
                                  return SeatsContainer(
                                    id: id,
                                    available: isSeatAvailable(
                                        id, apiSeats!.locations),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 35,
                          width: 3,
                          color: Colors.grey,
                        ),
                        Expanded(child: Container()),
                        Container(
                          height: 40,
                          width: 3,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 3),
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            color: Color(0xffe1cf24),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                  right: -7,
                                  top: 4,
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.grey,
                                    child: CircleAvatar(
                                        radius: 5,
                                        backgroundColor: scaffold,
                                        child: const Icon(
                                          Icons.close_sharp,
                                          color: Colors.grey,
                                          size: 11,
                                        )),
                                  ))
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        Expanded(child: Container()),
                        SeatsContainer(
                            // height: 20,
                            // width: 20,
                            id: 2,
                            available: isSeatAvailable(2, apiSeats!.locations)),
                        const SizedBox(
                          height: 1,
                        ),
                        SeatsContainer(
                            // height: 20,
                            // width: 20,
                            id: 1,
                            available: isSeatAvailable(1, apiSeats.locations))
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
          const SizedBox(
            height: 10,
          ),
          CoverContainer(children: [
            Theme(
              data: Theme.of(context).copyWith(
                dialogTheme: DialogTheme(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 0.0,
                ),
              ),
              child: MultiSelectDialogField(
                backgroundColor: Colors.white,
                items: availableSeats
                    .map((number) => MultiSelectItem<int>(
                        number, "Seat#  ${number.toString()}"))
                    .toList(),
                title: const Text("Select seats"),
                selectedColor: primarySwatch,
                decoration: BoxDecoration(
                  color: scaffold,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: scaffold,
                  ),
                ),
                buttonIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
                buttonText: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  setState(() {
                    selectedSeats = results.cast<int>();
                    responseBody["seats"] = selectedSeats
                        .map((seat) => {"seat": seat.toString()})
                        .toList();
                    buttonText = selectedSeats.isEmpty
                        ? "Select seats"
                        : "Selected: ${selectedSeats.join(", ")}";
                  });
                },
                chipDisplay: MultiSelectChipDisplay(
                  items: selectedSeats
                      .map((seat) => MultiSelectItem<int>(seat, "Seat# $seat"))
                      .toList(),
                  onTap: (value) {
                    setState(() {
                      selectedSeats.remove(value);
                      responseBody["seats"] = selectedSeats
                          .map((seat) => {"seat": seat.toString()})
                          .toList();
                      buttonText = selectedSeats.isEmpty
                          ? "Select seats"
                          : "Selected: ${selectedSeats.join(", ")}";
                    });
                  },
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  chipColor: primarySwatch,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(color: primarySwatch),
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: scaffold,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(5))),
            //     onPressed: () {
            //       context.push("/payment");
            //     },
            //     child: const Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           "Take seats",
            //           style: TextStyle(
            //               color: primarySwatch, fontWeight: FontWeight.bold),
            //         ),
            //       ],
            //     ))
          ]),
          const Spacer(),
          ref.watch(bookingProvider)!.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: StyleUtls.buttonStyle,
                    onPressed: () {
                      ref
                          .read(bookingProvider.notifier)
                          .bookSeats(context, ref, responseBody);
                      // Perform the booking action with responseBody
                      print(responseBody);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Book seats",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
