import 'package:flutter/material.dart';
import 'package:simple_player/pages/music_list/music_list_page.dart';
import 'package:simple_player/pages/player/player_page.dart';
import 'package:simple_player/providers/media_list_provider.dart';

class HomePage extends StatefulWidget {
  HomePage(this.mediaListProvider);

  final MediaListProvider mediaListProvider;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    widget.mediaListProvider.getMediaList();
  }

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
