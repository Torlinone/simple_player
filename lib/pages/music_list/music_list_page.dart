import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:simple_player/providers/media_list_provider.dart';

class MusicListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('music list page'),
      ),
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
          return CircularProgressIndicator();
        }

        if (mediaListProvider.mediaList is List && mediaListProvider.mediaList.isNotEmpty) {
          final List<SongInfo> list = mediaListProvider.mediaList;
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) => Text(list[index].title),
            itemCount: list.length,
            itemExtent: 40,
          );
        }

        return Container();
      },
    );
  }
}
