import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:save_the_bees/save_the_bees_game.dart';

void main() async {
  Flame.images.loadAll(<String>[
    'bee-eater.png',
    'bee-eater-dead.png',
    'bee-1.png',
    'bee-2.png',
    'bee-dead.png',
    'bg.png',
    'fly-swatter.png',
    'fly-swatter-dead.png',
    'pesticide.png',
    'pesticide-dead.png',
    'soap.png',
    'soap-dead.png',
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
