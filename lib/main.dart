import 'package:flutter/material.dart';
import 'package:simple_player/common/style/custom_theme.dart';
import 'package:simple_player/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: CustomTheme.systemTheme(context, Brightness.dark),
      home: HomePage(),
    );
  }
}
