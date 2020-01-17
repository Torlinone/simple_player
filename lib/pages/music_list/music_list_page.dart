import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:simple_player/providers/media_list_provider.dart';
import 'package:simple_player/providers/player_provider.dart';

class MusicListPage extends StatefulWidget {
  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage>
    with AutomaticKeepAliveClientMixin<MusicListPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: Text('music list page')),
      body: MediaList(),
    );
  }
}

class MediaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MediaListProvider>(
      builder: (BuildContext context, MediaListProvider mediaListProvider, _) {
        if (mediaListProvider.loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (mediaListProvider.mediaList is List && mediaListProvider.mediaList.isNotEmpty) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) => MediaItem(
              mediaListProvider.mediaList[index],
              albumPath: mediaListProvider.mediaList[index].albumId == null
                  ? null
                  : mediaListProvider.queryAlbumInCache(mediaListProvider.mediaList[index].albumId),
            ),
            itemCount: mediaListProvider.mediaList.length,
          );
        }

        return Container();
      },
    );
  }
}

class MediaItem extends StatelessWidget {
  MediaItem(this.media, {this.albumPath});

  final SongInfo media;
  final String albumPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: albumPath == null ? null : Image.file(File(albumPath)),
        title: Text(media.title),
        trailing: Selector<PlayerProvider, String>(
          selector: (BuildContext context, PlayerProvider playerProvider) =>
              playerProvider.curSongId,
          builder: (BuildContext context, String curId, _) {
            Widget icon = curId == media.id ? Icon(Icons.pause) : Icon(Icons.play_arrow);
            return IconButton(
              onPressed: () {
                // todo play and set curSong info
                final PlayerProvider provider = Provider.of<PlayerProvider>(context);
              },
              icon: icon,
            );
          },
        ),
      ),
    );
  }
}
