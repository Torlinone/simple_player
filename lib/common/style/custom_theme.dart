import 'package:flutter/material.dart';

class CustomTheme {
  CustomTheme({
    this.lightShadowColor,
    this.darkShadowColor,
    this.lightBorderColor,
    this.darkBorderColor,
    this.lightShadowBlur,
    this.weightShadowBlur,
    this.lightShadowOffset,
    this.weightShadowOffset,
    this.actionGradient,
  });

  Color lightShadowColor;
  Color darkShadowColor;

  Color lightBorderColor;
  Color darkBorderColor;

  double lightShadowBlur;
  double weightShadowBlur;

  Offset lightShadowOffset;
  Offset weightShadowOffset;

  Gradient actionGradient;

  // todo : all same to dark , will be set in v2.0
  factory CustomTheme.light() => CustomTheme(
        lightShadowColor: Color.fromARGB(255, 46, 42, 53),
        darkShadowColor: Color.fromARGB(255, 85, 59, 60),
        darkBorderColor: Color.fromARGB(255, 31, 36, 42),
        lightBorderColor: Color.fromARGB(255, 31, 36, 42),
        lightShadowOffset: Offset.zero,
        weightShadowOffset: Offset.zero,
        actionGradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            Color.fromARGB(255, 51, 54, 59),
            Color.fromARGB(255, 37, 40, 45),
          ],
        ),
        lightShadowBlur: 3,
        weightShadowBlur: 3,
      );

  factory CustomTheme.dark() => CustomTheme(
        lightShadowColor: Color.fromARGB(255, 46, 42, 53),
        darkShadowColor: Color.fromARGB(255, 85, 59, 60),
        darkBorderColor: Color.fromARGB(255, 31, 36, 42),
        lightBorderColor: Color.fromARGB(255, 31, 36, 42),
        lightShadowOffset: Offset.zero,
        weightShadowOffset: Offset.zero,
        actionGradient: LinearGradient(
          begin:Alignment.topCenter,
          end:Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 37, 40, 45),
            Color.fromARGB(255, 51, 54, 59),
          ],
        ),
        lightShadowBlur: 3,
        weightShadowBlur: 3,
      );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(elevation: 0),
    scaffoldBackgroundColor: Color(0xFF2E3439),
    primarySwatch: MaterialColor(
      0xFF2E3439,
      {
        50: Color(0xFF8293A1),
        100: Color(0xFF768693),
        200: Color(0xFF6D7B87),
        300: Color(0xFF606D78),
        400: Color(0xFF515C66),
        500: Color(0xFF48535C),
        600: Color(0xFF3F4850),
        700: Color(0xFF384046),
        800: Color(0xFF30383E),
        900: Color(0xFF2E3439),
      },
    ),
  );

  // todo : all same to darkTheme , will be set in v2.0
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(elevation: 0),
    scaffoldBackgroundColor: Color(0xFF2E3439),
    primarySwatch: MaterialColor(
      0xFF2E3439,
      {
        50: Color(0xFF8293A1),
        100: Color(0xFF768693),
        200: Color(0xFF6D7B87),
        300: Color(0xFF606D78),
        400: Color(0xFF515C66),
        500: Color(0xFF48535C),
        600: Color(0xFF3F4850),
        700: Color(0xFF384046),
        800: Color(0xFF30383E),
        900: Color(0xFF2E3439),
      },
    ),
  );

  static CustomTheme of(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark ? CustomTheme.dark() : CustomTheme.light();
  }

  static ThemeData systemTheme(BuildContext context, [Brightness brightness]) {
    Brightness _brightness = brightness ?? MediaQuery.of(context).platformBrightness;
    return _brightness == Brightness.dark ? darkTheme : lightTheme;
  }
}
