import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_player/common/style/custom_theme.dart';

class PlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('player page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: ThumbList()),
          Spectrum(),
          PlayerController(),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}

class ThumbList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blueGrey);
  }
}

class Spectrum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 40,
      color: Colors.blueGrey,
    );
  }
}

class PlayerController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orangeAccent,
              border: Border.all(width: 1, color: CustomTheme.of(context).darkShadowColor)),
        ),
      ),
    );
  }
}
