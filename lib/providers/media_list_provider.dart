import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class MediaListProvider with ChangeNotifier {
  MediaListProvider() {
    getMediaList();
  }

  final FlutterAudioQuery audioQuery = FlutterAudioQuery();

  List<SongInfo> get mediaList => _mediaList;
  List<SongInfo> _mediaList;

  List<AlbumInfo> get albumInfo => _albumInfo;
  List<AlbumInfo> _albumInfo;

  bool get hasInit => _hasInit;
  bool _hasInit = false;

  bool get loading => _loading;
  bool _loading = false;

  Future<void> getMediaList([bool notify = true]) async {
    if (notify) {
      _loading = true;
      notifyListeners();
    }
    _hasInit = false;

    List<SongInfo> list = await audioQuery.getSongs();
    _albumInfo = await audioQuery.getAlbums();

    if (list is List && list.isNotEmpty) {
      _mediaList = list.where((item) => item.isMusic).toList();
    }
    _hasInit = true;
    if (notify) {
      _loading = false;
      notifyListeners();
    }
  }

  // 通过专辑id找到专辑的封面地址
  String queryAlbumInCache(String id) {
    if (_albumInfo is List && _albumInfo.isNotEmpty) {
      return _albumInfo.firstWhere((item) => item.id == id, orElse: () => null)?.albumArt;
    }
    return null;
  }
}
