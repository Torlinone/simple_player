import 'package:flutter/material.dart';
import 'package:simple_player/pages/player/player_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(elevation: 0),
        scaffoldBackgroundColor:  Color(0xFF2E3439),
        primarySwatch: MaterialColor(0xFF2E3439, {
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
        }),
      ),
      home: PlayerPage(),
    );
  }
}
