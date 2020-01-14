import 'package:flutter/material.dart';
import 'package:simple_player/pages/music_list/music_list_page.dart';
import 'package:simple_player/pages/player/player_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          PlayerPage(),
          MusicListPage(),
        ],
      ),
    );
  }
}
