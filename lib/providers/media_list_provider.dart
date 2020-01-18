import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class MediaListProvider with ChangeNotifier {
  MediaListProvider() {
    init();
  }

  final FlutterAudioQuery audioQuery = FlutterAudioQuery();

  List<SongInfo> get mediaList => _mediaList;
  List<SongInfo> _mediaList;

  List<AlbumInfo> get albumInfo => _albumInfo;
  List<AlbumInfo> _albumInfo;

  List<MediaItem> get mediaInfoList => _mediaInfoList;
  List<MediaItem> _mediaInfoList;

  bool get hasInit => _hasInit;
  bool _hasInit = false;

  bool get loading => _loading;
  bool _loading = false;

  Future<void> init() async {
    await getMediaList();
    _mediaInfoList = makeMediaInfoListFromMediaList(_mediaList);
  }

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
  String queryAlbumImgInCache(String albumId) {
    if (_albumInfo is List && _albumInfo.isNotEmpty) {
      return queryAlbumInCache(albumId)?.albumArt;
    }
    return null;
  }

  // 通过专辑id找到专辑信息
  AlbumInfo queryAlbumInCache(String albumId) {
    if (_albumInfo is List && _albumInfo.isNotEmpty) {
      return _albumInfo.firstWhere((item) => item.id == albumId, orElse: () => null);
    }
    return null;
  }

  List<MediaItem> makeMediaInfoListFromMediaList(List<SongInfo> mediaList) {
    if (mediaList is List && mediaList.isNotEmpty) {
      return mediaList
          .map((item) => MediaItem(
                id: item.filePath,
                album: item.album,
                title: item.title,
                artist: item.artist,
                duration: int.tryParse(item.duration),
                artUri: item.albumId == null
                    ? null
                    : (queryAlbumImgInCache(item.albumId) == null
                        ? null
                        : Uri.file(queryAlbumImgInCache(item.albumId)).path),
              ))
          .toList();
    }
    return null;
  }

//  final _queue = <MediaItem>[
//    MediaItem(
//      id: "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
//      album: "Science Friday",
//      title: "A Salute To Head-Scratching Science",
//      artist: "Science Friday and WNYC Studios",
//      duration: 5739820,
//      artUri: "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
//    ),
//    MediaItem(
//      id: "https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3",
//      album: "Science Friday",
//      title: "From Cat Rheology To Operatic Incompetence",
//      artist: "Science Friday and WNYC Studios",
//      duration: 2856950,
//      artUri: "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
//    ),
//  ];
}
