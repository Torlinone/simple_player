import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_player/pages/home.dart';
import 'package:simple_player/providers/media_list_provider.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MediaListProvider>(
        builder: (BuildContext context, MediaListProvider listProvider, _) {
          if (listProvider.hasInit) {
            print('splash page nav home ---');
            Future.microtask(() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(),
                ),
              );
            });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
