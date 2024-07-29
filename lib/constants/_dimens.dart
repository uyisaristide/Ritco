import 'package:flutter/material.dart';

class ScreenWidth {
  static const double extraSmall400 = 400;
  static const double extraSmall480 = 480;
  static const double extraSmall = 600;
  static const double extraSmall660 = 660;
  static const double small = 900;
  static const double medium = 1200;
  static const double medium1050 = 1050;
  static const double large = 1536;
  static const double extraLarge = double.maxFinite;
}

bool isExtraSmall(BuildContext context) {
  return MediaQuery.of(context).size.width <= ScreenWidth.extraSmall400;
}

bool isExtraSmall2(BuildContext context) {
  return MediaQuery.of(context).size.width > ScreenWidth.extraSmall400;
}

bool isSmall(BuildContext context) {
  return MediaQuery.of(context).size.width <= ScreenWidth.extraSmall;
}

bool isSmall2(BuildContext context) {
  return MediaQuery.of(context).size.width > ScreenWidth.extraSmall;
}

bool isSmall900(BuildContext context) {
  return MediaQuery.of(context).size.width <= ScreenWidth.small;
}

bool isSmall9002(BuildContext context) {
  return MediaQuery.of(context).size.width > ScreenWidth.small;
}

bool isMedium(BuildContext context) {
  return MediaQuery.of(context).size.width <= ScreenWidth.medium;
}

bool isMedium2(BuildContext context) {
  return MediaQuery.of(context).size.width > ScreenWidth.medium;
}

bool isLarge(BuildContext context) {
  return MediaQuery.of(context).size.width <= ScreenWidth.large;
}

bool isLarge2(BuildContext context) {
  return MediaQuery.of(context).size.width > ScreenWidth.large;
}
