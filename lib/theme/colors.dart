import 'package:flutter/material.dart';

Color blackColor = Colors.black;
Color formFieldsColor = const Color(0xffF4F4F4);

MaterialColor createMaterialColor(Color color) {
  List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int strength in strengths) {
    swatch[strength] =
        Color.fromRGBO(r, g, b, (strength / 900).clamp(0.0, 1.0));
  }

  return MaterialColor(color.value, swatch);
}

// MaterialColor primarySwatch = createMaterialColor(const Color(0xff264E9A));
// const Color primaryColor = Color(0xFF0181C6);

const int primaryColorValue = 0xff8db600;

const MaterialColor primarySwatch = MaterialColor(
  primaryColorValue,
  {
    50: Color(0xfff0f8e1),
    100: Color(0xffdbe8b4),
    200: Color(0xffc3d882),
    300: Color(0xffaac84f),
    400: Color(0xff94ba28),
    500: Color(primaryColorValue),  // Primary color
    600: Color(0xff82a300),
    700: Color(0xff759100),
    800: Color(0xff697f00),
    900: Color(0xff506000),
  },
);

Color scaffold = const Color(0xffF6F6F6);
Color primaryText = const Color(0xff202123);
Color secondarTex = const Color(0xff5F6368);
Color fieldsBackground = const Color(0xffFFFFFF);
Color fieldsBorder = const Color(0xffDADCE0);
Color errorColor = const Color(0xffD93025);
Color successColor = const Color(0xff34A853);
Color accentColor = const Color(0xff6DAA3C);

