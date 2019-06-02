import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:save_the_bees/save_the_bees_game.dart';

void main() async {
  Flame.images.loadAll(<String>[
    'bee-eater.png',
    'bee.png',
    'bg.png',
    'fly-swatter.png',
    'pesticide.png',
  ]);

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  SaveTheBeesGame game = SaveTheBeesGame();
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}
