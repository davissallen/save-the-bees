import 'dart:ui' as ui;

import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiver/iterables.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:save_the_bees/save_the_bees_game.dart';

void main() async {
  Flame.audio.disableLog();

  Map<String, String> imageMap = {
    'sprites': 'spritesheet.png',
    'background': 'background.png',
  };
  Flame.images.loadAll(imageMap.values.toList());

  Flame.audio.loadAll(<String>[
    'sfx/kill1.wav',
    'sfx/kill2.wav',
    'sfx/kill3.wav',
    'sfx/kill4.wav',
    'sfx/kill5.wav',
    'sfx/kill6.wav',
    'sfx/die.wav',
    'music/bensound-summer.mp3',
  ]);

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  SharedPreferences storage = await SharedPreferences.getInstance();

  SaveTheBeesGame game = SaveTheBeesGame(
    storage,
    spriteSheetImage: imageMap['sprites'],
    backgroundImage: imageMap['background'],
  );
  runApp(MaterialApp(
    title: 'Save the Bees',
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: GameWrapper(game),
    ),
  ));

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}

class GameWrapper extends StatelessWidget {
  final SaveTheBeesGame game;

  GameWrapper(this.game);

  @override
  Widget build(BuildContext context) {
    return game.widget;
  }
}
