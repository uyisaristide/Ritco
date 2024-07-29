import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ritco_app/models/location.dart';
import 'package:ritco_app/riverpod/providers/auth_providers.dart';
import 'package:ritco_app/riverpod/providers/home.dart';
import 'package:ritco_app/views/home/widgets/cover_container.dart';
import '../../theme/colors.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart' as vector_icons;

class RiderScreen extends ConsumerStatefulWidget {
  const RiderScreen({super.key});

  @override
  ConsumerState<RiderScreen> createState() => _RiderScreenState();
}

class _RiderScreenState extends ConsumerState<RiderScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(districtsProvider.notifier).districts(context);
    });

    super.initState();
  }

  List<String> places = ['Nyabugogo', "Kibungo", "Kayonza", "Muhanga"];

  final selectedDistrictProvider = StateProvider<String?>((ref) => null);
  final selectedLocationProvider = StateProvider<Location?>((ref) => null);
  final selectedDestinationProvider = StateProvider<Location?>((ref) => null);

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    var districts = ref.watch(districtsProvider);
    var schedules = ref.watch(schedulesProvider);
    var locations = ref.watch(locationsProvider);
    var destinations = ref.watch(destinationProvider);
    var selectedLocation = ref.watch(selectedLocationProvider);
    var selectedDestinationLocation = ref.watch(selectedDestinationProvider);
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, top: 60, right: 20),
                height: 300,
                width: double.maxFinite,
                color: primarySwatch,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Text(
                            "${user!.user!.fname.substring(0, 1)} ${user.user!.lname.substring(0, 1)}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primarySwatch),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${user!.user!.role}",
                              style: const TextStyle(
                                  color: Colors.yellowAccent, fontSize: 12),
                            ),
                            Text(
                              "${user!.user!.fname} ${user.user!.lname}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const CircleAvatar(
                            backgroundColor: Color(0x0f34601b),
                            child: Icon(
                              vector_icons.Ionicons.notifications_outline,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "welcome.title",
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ).tr()
                  ],
                ),
              ),
              Container(
                height: 2000,
              )
            ],
          ),
          Positioned(
            top: 230,
            right: 15,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CoverContainer(
                  horizontalPadding: 15,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: DropdownButtonFormField(
                        // validator: validateEmptyness,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(vector_icons.Ionicons.location),
                          filled: true,
                          fillColor: scaffold,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "welcome.depDistrict".tr(),
                        ),
                        items: districts!.orders
                            .map((place) => DropdownMenuItem(
                                value: place, child: Text(place.districtName)))
                            .toList(),
                        onChanged: (value) {
                          ref
                              .read(locationsProvider.notifier)
                              .locations(context, value!.districtName);
                          ref.read(selectedLocationProvider.notifier).state =
                              null;
                          ref.read(selectedDistrictProvider.notifier).state =
                              null;
                          ref.read(selectedDestinationProvider.notifier).state =
                              null;
                          ref
                              .read(destinationProvider.notifier)
                              .clearLocations();
                          ref.read(schedulesProvider.notifier).clearSchedules();
                        },
                      ),
                    ),
                    if (locations!.locations.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: DropdownButtonFormField(
                          // validator: validateEmptyness,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(vector_icons.Ionicons.location),
                            filled: true,
                            fillColor: scaffold,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: "welcome.depLocation".tr(),
                          ),
                          items: locations.locations
                              .map((place) => DropdownMenuItem(
                                  value: place, child: Text(place.name)))
                              .toList(),
                          onChanged: (value) {
                            ref.read(selectedLocationProvider.notifier).state =
                                value;
                            // print(selectedLocation!.locationId);
                          },
                        ),
                      ),
                    if (selectedLocation != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: DropdownButtonFormField(
                          // validator: validateEmptyness,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(vector_icons.Ionicons.location),
                            filled: true,
                            fillColor: scaffold,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: "welcome.destDistrict".tr(),
                          ),
                          items: districts.orders
                              .map((place) => DropdownMenuItem(
                                  value: place,
                                  child: Text(place.districtName)))
                              .toList(),
                          onChanged: (value) {
                            ref
                                .read(destinationProvider.notifier)
                                .locations(context, value!.districtName);
                          },
                        ),
                      ),
                    if (destinations!.locations.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: DropdownButtonFormField(
                          // validator: validateEmptyness,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(vector_icons.Ionicons.location),
                            filled: true,
                            fillColor: scaffold,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: "welcome.destLocation".tr(),
                          ),
                          items: destinations.locations
                              .map((place) => DropdownMenuItem(
                                  value: place, child: Text(place.name)))
                              .toList(),
                          onChanged: (value) {
                            ref
                                .read(selectedDestinationProvider.notifier)
                                .state = value;
                            // print(selectedDestinationLocation!.locationId);
                          },
                        ),
                      ),
                    if (selectedDestinationLocation != null)
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primarySwatch,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            ref
                                .read(schedulesProvider.notifier)
                                .schedules(context, {
                              "departure":
                                  selectedLocation!.locationId, // Location id
                              "destination": selectedDestinationLocation
                                  .locationId, // location id
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "welcome.search".tr(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                if (schedules!.locations.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 10),
                    child: Text(
                      "welcome.results".tr(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                schedules!.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 8.0),
                        itemCount: schedules!.locations.length,
                        itemBuilder: (context, index) {
                          final booking = schedules.locations[index];
                          return InkWell(
                            onTap: () {
                              ref
                                  .read(selectedLocationProvider.notifier)
                                  .state = null;
                              ref
                                  .read(selectedDistrictProvider.notifier)
                                  .state = null;
                              ref
                                  .read(selectedDestinationProvider.notifier)
                                  .state = null;
                              ref
                                  .read(destinationProvider.notifier)
                                  .clearLocations();
                              ref
                                  .read(schedulesProvider.notifier)
                                  .clearSchedules();
                              context.push('/booking', extra: booking);
                            },
                            child: CoverContainer(
                              children: [
                                address("welcome.departure".tr(),
                                    booking.departure),
                                address("welcome.destination".tr(),
                                    booking.destination),
                                address(
                                    "welcome.time".tr(), booking.departureTime),
                                address("welcome.fare".tr(), booking.fare),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget address(String attr, String vle) {
  return Row(
    children: [
      SizedBox(
        width: 100,
        child: Text(
          attr,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      Flexible(
        child: Text(
          vle,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    ],
  );
}

// Future<void> _showLocationSelector(BuildContext context) async {
//   await showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return Consumer(
//         builder: (context, watch, child) {
//           var districts = ref.watch(districtsProvider);
//           var locations = ref.watch(mylocationProvider);
//           var selectedDistrict = ref.watch(selectedDistrictProvider);
//           var selectedLocation = ref.watch(selectedLocationProvider);
//
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 DropdownButtonFormField(
//                   // validator: validateEmptyness,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(vector_icons.Ionicons.location),
//                     filled: true,
//                     fillColor: scaffold,
//                     border: const OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                     ),
//                     hintText: "Departure Location",
//                   ),
//                   items: districts!.orders
//                       .map((place) => DropdownMenuItem(
//                       value: place, child: Text(place.districtName)))
//                       .toList(),
//                   onChanged: (value) {
//                     ref.read(selectedDistrictProvider.notifier).state =
//                         value!.districtName;
//                     ref
//                         .read(locationsProvider.notifier)
//                         .locations(context, value.districtName);
//                     ref.read(mylocationProvider.notifier).state =
//                         ref.watch(locationsProvider)!.locations;
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 // if (selectedDistrict != null)
//                 DropdownButtonFormField(
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(vector_icons.Ionicons.locate),
//                     filled: true,
//                     fillColor: scaffold,
//                     border: const OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                     ),
//                     hintText: "Select Location",
//                   ),
//                   items: locations
//                       .map((place) => DropdownMenuItem(
//                       value: place, child: Text(place.name)))
//                       .toList(),
//                   onChanged: (value) {
//                     ref.read(selectedLocationProvider.notifier).state =
//                         value;
//                     // setState(() {
//                     //   selectedLocation = value;
//                     // });
//                   },
//                   // value: selectedLocation,
//                 ),
//                 const SizedBox(height: 15),
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     Navigator.pop(context);
//                 //   },
//                 //   child: const Text("OK"),
//                 // ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }
//
// Future<void> _showDestinationSelector(BuildContext context) async {
//   await showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return Consumer(
//         builder: (context, watch, child) {
//           var districts = ref.watch(districtsProvider);
//           var destinations = ref.watch(destinationProvider);
//           var selectedDestinationDistrict =
//           ref.watch(selectedLocationProvider);
//
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 DropdownButtonFormField(
//                   // validator: validateEmptyness,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(vector_icons.Ionicons.location),
//                     filled: true,
//                     fillColor: scaffold,
//                     border: const OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                     ),
//                     hintText: "Departure Location",
//                   ),
//                   items: districts!.orders
//                       .map((place) => DropdownMenuItem(
//                       value: place, child: Text(place.districtName)))
//                       .toList(),
//                   onChanged: (value) {
//                     ref
//                         .read(selectedDestinationDistrictsProvider.notifier)
//                         .state = value!.districtName;
//                     ref
//                         .read(destinationProvider.notifier)
//                         .locations(context, value.districtName);
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 if (selectedDestinationDistrict != null)
//                   DropdownButtonFormField(
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(vector_icons.Ionicons.locate),
//                       filled: true,
//                       fillColor: scaffold,
//                       border: const OutlineInputBorder(
//                         borderSide: BorderSide.none,
//                       ),
//                       hintText: "Select Location",
//                     ),
//                     items: destinations!.locations
//                         .map((place) => DropdownMenuItem(
//                         value: place, child: Text(place.name)))
//                         .toList(),
//                     onChanged: (value) {
//                       ref
//                           .read(selectedDestinationLocationProvider.notifier)
//                           .state = value;
//                     },
//                     // value: selectedLocation,
//                   ),
//                 const SizedBox(height: 15),
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     Navigator.pop(context);
//                 //   },
//                 //   child: const Text("OK"),
//                 // ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }
