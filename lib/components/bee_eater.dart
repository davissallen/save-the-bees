import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:save_the_bees/components/enemy.dart';
import 'package:save_the_bees/save_the_bees_game.dart';

class BeeEater extends Enemy {
  static final double relativeSize = 1.5;

  double get speed => game.tileSize * 4;

  BeeEater(SaveTheBeesGame game, double x, double y) : super(game) {
    enemyRect = Rect.fromLTWH(
      x,
      y,
      game.tileSize * relativeSize,
      game.tileSize * relativeSize / 2.35,
    );
    aliveSprite = (Sprite('enemies/bee-eater.png'));
    deadSprite = Sprite('enemies/bee-eater-dead.png');
  }
}
