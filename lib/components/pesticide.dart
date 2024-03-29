import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:save_the_bees/components/enemy.dart';
import 'package:save_the_bees/save_the_bees_game.dart';

class Pesticide extends Enemy {
  static final double relativeSize = 1;

  double get speed => game.tileSize * 2;


  Pesticide(SaveTheBeesGame game, double x, double y) : super(game) {
    enemyRect = Rect.fromLTWH(
      x,
      y,
      game.tileSize * relativeSize / 1.92,
      game.tileSize * relativeSize,
    );
    aliveSprite = (Sprite('enemies/pesticide.png'));
    deadSprite = Sprite('enemies/pesticide-dead.png');
  }
}
