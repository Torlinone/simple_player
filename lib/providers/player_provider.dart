import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_player/pages/player/background_task.dart';
import 'package:simple_player/providers/media_list_provider.dart';

class PlayerProvider with ChangeNotifier {
  PlayerProvider() {
    init();
  }

  StreamSubscription _screenStateSub;

  static AudioPlayer get audioPlayer => _audioPlayer;
  static AudioPlayer _audioPlayer = AudioPlayer();

  BasicPlaybackState get basicPlaybackState => _basicPlaybackState ?? BasicPlaybackState.none;
  BasicPlaybackState _basicPlaybackState;

  int get curPosition => _curPosition;
  int _curPosition;

  static Future<void> connect() async {
    await AudioService.connect();
  }

  static Future<void> disconnect() async {
    await AudioService.disconnect();
  }

  static Future<void> Function() get play => AudioService.play;

  static Future<void> Function() get pause => AudioService.pause;

  static Future<void> Function() get stop => AudioService.stop;

  void init() {
    _screenStateSub = Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState, ScreenState>(
            AudioService.queueStream,
            AudioService.currentMediaItemStream,
            AudioService.playbackStateStream,
            (queue, mediaItem, playbackState) => ScreenState(queue, mediaItem, playbackState))
        .listen((ScreenState screenState) {
//      final queue = screenState?.queue;
      final mediaItem = screenState?.mediaItem;
      final state = screenState?.playbackState;
      _basicPlaybackState = state?.basicState ?? BasicPlaybackState.none;
      _curPosition = state?.currentPosition;
      notifyListeners();
      return screenState;
    });
  }

  static Future<void> backgroundTaskEntryPoint() async {
    AudioServiceBackground.run(() => AudioPlayerTask(MediaListProvider.mediaInfoList, _audioPlayer));
  }

//  static backgroundTaskEntryPointProvider(List<MediaItem> queue, AudioPlayer player) {
//    return () async {
//      AudioServiceBackground.run(() => AudioPlayerTask(queue, player));
//    };
//  }

  static Future<bool> start(List<MediaItem> queue) {
    if (queue is List && queue.isNotEmpty) {
      return AudioService.start(
        backgroundTaskEntrypoint: backgroundTaskEntryPoint,
        resumeOnClick: true,
        androidNotificationChannelName: 'simple_player',
        notificationColor: 0xFF2196f3,
        androidNotificationIcon: 'mipmap/ic_launcher',
      );
    } else {
      return Future.value(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _screenStateSub.cancel();
  }
}

class ScreenState {
  final List<MediaItem> queue;
  final MediaItem mediaItem;
  final PlaybackState playbackState;

  ScreenState(this.queue, this.mediaItem, this.playbackState);
}
