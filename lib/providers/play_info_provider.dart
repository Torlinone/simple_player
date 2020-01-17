import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:simple_player/providers/media_list_provider.dart';
import 'package:simple_player/providers/player_provider.dart';

class PlayInfoProvider with ChangeNotifier {

  PlayerProvider player;
  MediaListProvider list;

  SongInfo get playingSong => _playingSong;
  SongInfo _playingSong;

  AlbumInfo get playingAlbum => _playingAlbum;
  AlbumInfo _playingAlbum;

  void setPlayingSong(SongInfo song, [bool notify = true]) {
    if (song != null) {
      _playingSong = song;
      _playingAlbum = list.queryAlbumInCache(song.albumId);
      if (notify) {
        notifyListeners();
      }
    }
  }
}
