import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:simple_player/common/style/custom_theme.dart';
import 'package:simple_player/providers/media_list_provider.dart';
import 'package:simple_player/providers/player_provider.dart';

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
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
    return WillPopScope(
      onWillPop: () {
        PlayerProvider.disconnect();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('player page'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: ThumbList()),
            Spectrum(),
            PlayerController(),
            SizedBox(height: MediaQuery.of(context).padding.bottom)
          ],
        ),
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
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orangeAccent,
                border: Border.all(width: 1, color: CustomTheme.of(context).darkShadowColor),
              ),
              child: Container(
                margin: const EdgeInsets.all(70),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: CustomTheme.of(context).darkShadowColor),
                  gradient: CustomTheme.of(context).actionGradient,
                  shape: BoxShape.circle,
                ),
                child: Selector<PlayerProvider, BasicPlaybackState>(
                  selector: (BuildContext context, PlayerProvider provider) => provider.basicPlaybackState,
                  builder: (BuildContext context, BasicPlaybackState state, _) {
                    print('------------------');
                    print(state);
                    return IconButton(
                      icon: state == null ||
                              state == BasicPlaybackState.none ||
                              state == BasicPlaybackState.paused ||
                              state == BasicPlaybackState.stopped
                          ? Icon(Icons.play_arrow)
                          : Icon(Icons.pause),
                      onPressed: () async {
                        if (state == null || state == BasicPlaybackState.none) {
                          final MediaListProvider listProvider = Provider.of<MediaListProvider>(context, listen: false);
//                          final PlayerProvider playerProvider = Provider.of<PlayerProvider>(context, listen: false);
                          final bool res = await PlayerProvider.start(MediaListProvider.mediaInfoList);
                          print('----res -------');
                          print(res);
                          return;
                        }
                        if (state == BasicPlaybackState.paused) {
                          PlayerProvider.play();
                          return;
                        }
                        if (state == BasicPlaybackState.playing) {
                          PlayerProvider.pause();
                          return;
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            _ActionBtn(
              alignment: Alignment.topCenter,
              icon: Icons.add,
              onPressed: () {},
            ),
            _ActionBtn(
              alignment: Alignment.bottomCenter,
              icon: Icons.remove,
              onPressed: () {},
            ),
            _ActionBtn(
              alignment: Alignment.centerLeft,
              icon: Icons.skip_previous,
              onPressed: AudioService.skipToPrevious,
            ),
            _ActionBtn(
              alignment: Alignment.centerRight,
              icon: Icons.skip_next,
              onPressed: AudioService.skipToNext,
            ),
          ],
        ),
      ),
    );
  }
}

// todo disable
class _ActionBtn extends StatelessWidget {
  _ActionBtn({
    Key key,
    @required this.alignment,
    @required this.onPressed,
    @required this.icon,
  }) : super(key: key);

  final AlignmentGeometry alignment;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 70,
        height: 70,
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
