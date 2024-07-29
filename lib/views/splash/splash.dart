import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:ritco_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/_assets.dart';
import '../../models/user_model.dart';
import '../../riverpod/notifiers/user_notifier.dart';
import '../../riverpod/providers/auth_providers.dart';
import '../../theme/colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
       ref.read(localeProvider.notifier).state= context.locale;
    });
    super.initState();

    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 3));
    await _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    // print(userData);
    if (userData != null) {
      final userMap = jsonDecode(userData) as Map<String, dynamic>;
      final user = UserModel.fromJson(userMap);
      ref.read(userProvider.notifier).state =
          UserState(isLoading: false, user: user);
      // if (user.userRole == 'Rider') {
      context.go('/home');
      // }
      // else {
      //   context.go("/homepage");
      // }
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: primarySwatch,
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsUtils.logo),
          // const SizedBox(
          //   height: 30,
          // ),
          // const Text(
          //   "ICPAR",
          //   style: TextStyle(
          //       fontSize: 25,
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold),
          // )
        ],
      ),
    ));
  }
}
