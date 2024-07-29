import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:ritco_app/riverpod/providers/auth_providers.dart';
import 'package:ritco_app/views/home/my_tickets.dart';
import 'package:ritco_app/views/home/notification_screen.dart';
import 'package:ritco_app/views/home/profile.dart';
import 'package:ritco_app/views/home/rider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart' as vector_icons;

class Homepage extends ConsumerStatefulWidget {
  final bool isSearching;
  const Homepage({super.key, this.isSearching = false});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  int _index = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // var user = ref.watch(userProvider);
      // if(user!.user!=null){
      //   await ref.read(cartProvider.notifier).myCart(context, user.user!.token);
      // }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          const RiderScreen(),
          const MyTickets(),
          const NotificationScreen(),
          const Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(vector_icons.AntDesign.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.ticket), label: "My tickets"),
          BottomNavigationBarItem(
              icon: Icon(vector_icons.Ionicons.notifications),
              label: "Notifications"),
          BottomNavigationBarItem(
              icon: Icon(vector_icons.Ionicons.person),
              label: "Account"),
        ],
      ),
    );
  }
}
