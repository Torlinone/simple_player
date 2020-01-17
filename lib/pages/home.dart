import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_player/pages/music_list/music_list_page.dart';
import 'package:simple_player/pages/player/player_page.dart';
import 'package:simple_player/providers/media_list_provider.dart';
import 'package:simple_player/providers/play_info_provider.dart';
import 'package:simple_player/providers/player_provider.dart';

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
      body: ChangeNotifierProxyProvider2<PlayerProvider, MediaListProvider, PlayInfoProvider>(
        create: (BuildContext context) => PlayInfoProvider(),
        update: (
          BuildContext context,
          PlayerProvider playerProvider,
          MediaListProvider listProvider,
          PlayInfoProvider infoProvider,
        ) =>
            infoProvider
              ..player = playerProvider
              ..list = listProvider,
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            PlayerPage(),
            MusicListPage(),
          ],
        ),
      ),
    );
  }
}
