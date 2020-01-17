import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_player/common/style/custom_theme.dart';
import 'package:simple_player/providers/player_provider.dart';

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {

  // todo play front and background
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    PlayerProvider.connect();
  }

  @override
  void dispose() {
    PlayerProvider.disconnect();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        PlayerProvider.connect();
        break;
      case AppLifecycleState.paused:
        PlayerProvider.disconnect();
        break;
      default:
        break;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('player page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: ThumbList()),
          Spectrum(),
          PlayerController(),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}

class ThumbList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blueGrey);
  }
}

class Spectrum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 40,
      color: Colors.blueGrey,
    );
  }
}

class PlayerController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orangeAccent,
              border: Border.all(width: 1, color: CustomTheme.of(context).darkShadowColor)),
        ),
      ),
    );
  }
}
