import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:save_the_bees/save_the_bees_game.dart';

void main() async {

  Flame.images.loadAll(<String>[
    'bg/bg.png',
    'bg/cloud.png',
    'branding/logo.png',
    'enemies/bee-eater.png',
    'enemies/bee-eater-dead.png',
    'enemies/pesticide.png',
    'enemies/pesticide-dead.png',
    'enemies/soap.png',
    'enemies/soap-dead.png',
    'enemies/fly-swatter.png',
    'enemies/fly-swatter-dead.png',
    'heroes/bee.png',
    'heroes/bee-1.png',
    'heroes/bee-2.png',
    'heroes/bee-dead.png',
    'menu/credits.png',
    'menu/help.png',
    'ui/lose.png',
    'ui/start.png',
    'ui/music-off.svg',
    'ui/music-on.svg',
    'ui/sfx-off.svg',
    'ui/sfx-on.svg',
  ]);

  Flame.audio.disableLog();
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

  SaveTheBeesGame game = SaveTheBeesGame(storage);
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}
