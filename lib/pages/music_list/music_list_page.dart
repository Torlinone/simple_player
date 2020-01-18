import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:simple_player/providers/media_list_provider.dart';
import 'package:simple_player/providers/play_info_provider.dart';

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
      bottomNavigationBar: PlayingBoard(),
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
            itemBuilder: (BuildContext context, int index) => MediaItemWidget(
              mediaListProvider.mediaList[index],
              albumPath: mediaListProvider.mediaList[index].albumId == null
                  ? null
                  : mediaListProvider
                      .queryAlbumImgInCache(mediaListProvider.mediaList[index].albumId),
            ),
            itemCount: mediaListProvider.mediaList.length,
          );
        }

        return Container();
      },
    );
  }
}

class MediaItemWidget extends StatelessWidget {
  MediaItemWidget(this.media, {this.albumPath});

  final SongInfo media;
  final String albumPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: albumPath == null ? null : Image.file(File(albumPath)),
        title: Text(media.title),
        trailing: Selector<PlayInfoProvider, String>(
          selector: (BuildContext context, PlayInfoProvider infoProvider) =>
              infoProvider.playingSong?.id,
          builder: (BuildContext context, String id, _) {
            Widget icon = id == media.id ? Icon(Icons.pause) : Icon(Icons.play_arrow);
            return IconButton(
              onPressed: () {
                final PlayInfoProvider infoProvider =
                    Provider.of<PlayInfoProvider>(context, listen: false);
                infoProvider.setPlayingSong(media);
              },
              icon: icon,
            );
          },
        ),
      ),
    );
  }
}

class PlayingBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayInfoProvider>(
      builder: (BuildContext context, PlayInfoProvider infoProvider, _) {
        return infoProvider.playingSong == null
            ? SizedBox(height: 0)
            : Container(
                height: 100,
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 46, 42, 53),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: MediaItemWidget(
                  infoProvider.playingSong,
                  albumPath: infoProvider.list.queryAlbumImgInCache(infoProvider.playingSong.id),
                ),
              );
      },
    );
  }
}
