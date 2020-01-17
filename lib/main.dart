import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_player/common/style/custom_theme.dart';
import 'package:simple_player/pages/home.dart';
import 'package:simple_player/providers/media_list_provider.dart';
import 'package:simple_player/providers/player_provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => MediaListProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => PlayerProvider())
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: CustomTheme.systemTheme(context, Brightness.dark),
      home: Consumer<MediaListProvider>(
        builder: (BuildContext context, MediaListProvider mediaListProvider, _) => HomePage(mediaListProvider),
      ),
    );
  }
}
