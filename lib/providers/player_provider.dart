import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class PlayerProvider with ChangeNotifier {
  String get curSongId => _curSongId;
  String _curSongId;

  static Future<void> connect() async {
    await AudioService.connect();
  }

  static Future<void> disconnect() async {
    await AudioService.disconnect();
  }
}
