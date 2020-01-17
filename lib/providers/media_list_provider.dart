import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class MediaListProvider with ChangeNotifier {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();

  List<SongInfo> mediaList;

  bool get loading => _loading;

  bool _loading = false;

  void getMediaList([bool notify = true]) async {
    if (notify) {
      _loading = true;
      notifyListeners();
    }
    List<SongInfo> list = await audioQuery.getSongs();
    if (list is List && list.isNotEmpty) {
      mediaList = list.where((item) => item.isMusic).toList();
    }
    if (notify) {
      _loading = false;
      notifyListeners();
    }
  }
}
