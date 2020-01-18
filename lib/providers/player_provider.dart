import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PlayerProvider with ChangeNotifier {
  PlayerProvider() {
    init();
  }

  StreamSubscription _screenStateSub;

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
    });
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
