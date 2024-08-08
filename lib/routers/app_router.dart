import 'package:go_router/go_router.dart';
import 'package:ritco_app/homepage.dart';
import 'package:ritco_app/models/schedule.dart';
import 'package:ritco_app/views/home/booking.dart';
import 'package:ritco_app/views/home/my_tickets.dart';
import 'package:ritco_app/views/home/notification_screen.dart';
import 'package:ritco_app/views/payments/failed_screen.dart';
import 'package:ritco_app/views/payments/payment_screen.dart';
import 'package:ritco_app/views/payments/sucess_screen.dart';

import '../views/auth/forgot_password.dart';
import '../views/auth/login.dart';
import '../views/auth/new_password.dart';
import '../views/auth/register.dart';
import '../views/auth/reset_password.dart';
import '../views/splash/splash.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
  GoRoute(
    path: '/login',
    builder: (context, state) => const SigninScreen(),
  ),
  GoRoute(
    path: '/newUser',
    builder: (context, state) => RegisterScreen(),
  ),
  GoRoute(
    path: '/forgetPassword',
    builder: (context, state) => const ForgotPassword(),
  ),
  GoRoute(
    path: '/resetPassword',
    builder: (context, state) => const ResetPasswordScreen(),
  ),
  GoRoute(
    path: '/newPassword',
    builder: (context, state) => const NewPasswordScreen(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const Homepage(),
  ),
  GoRoute(
    path: '/booking',
    builder: (context, state) {
      final schedule = state.extra as Schedule;
      return BookingScreen(schedule: schedule);
    },
  ),
  GoRoute(
    path: '/success',
    builder: (context, state) => const SuccessScreen(),
  ),
  GoRoute(
    path: '/failed',
    builder: (context, state) => const FailedScreen(),
  ),
  GoRoute(
    path: '/payment',
    builder: (context, state) {
      final schedule = state.extra as Schedule;
      return PaymentScreen(schedule: schedule);
    },
  ),
  GoRoute(
    path: '/notifications',
    builder: (context, state) => const NotificationScreen(),
  ),
  GoRoute(
    path: '/tickets',
    builder: (context, state) => const MyTickets(),
  ),

]);
