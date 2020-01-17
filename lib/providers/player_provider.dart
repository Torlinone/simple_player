import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class PlayerProvider with ChangeNotifier {
  static Future<void> connect() async {
    await AudioService.connect();
  }

  static Future<void> disconnect() async {
    await AudioService.disconnect();
  }

  /// MediaControl
  static MediaControl playControl = MediaControl(
    androidIcon: 'drawable/ic_action_play_arrow',
    label: 'Play',
    action: MediaAction.play,
  );

  static MediaControl pauseControl = MediaControl(
    androidIcon: 'drawable/ic_action_pause',
    label: 'Pause',
    action: MediaAction.pause,
  );

  static MediaControl skipToNextControl = MediaControl(
    androidIcon: 'drawable/ic_action_skip_next',
    label: 'Next',
    action: MediaAction.skipToNext,
  );

  static MediaControl skipToPreviousControl = MediaControl(
    androidIcon: 'drawable/ic_action_skip_previous',
    label: 'Previous',
    action: MediaAction.skipToPrevious,
  );

  static MediaControl stopControl = MediaControl(
    androidIcon: 'drawable/ic_action_stop',
    label: 'Stop',
    action: MediaAction.stop,
  );
}
