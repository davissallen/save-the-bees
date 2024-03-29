import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:save_the_bees/components/enemy.dart';
import 'package:save_the_bees/save_the_bees_game.dart';

class FlySwatter extends Enemy {
  static final double relativeSize = 3;

  double get speed => game.tileSize * 4;

  FlySwatter(SaveTheBeesGame game, double x, double y) : super(game) {
    enemyRect = Rect.fromLTWH(
      x,
      y,
      game.tileSize * relativeSize / 3.46,
      game.tileSize * relativeSize,
    );
    aliveSprite = (Sprite('enemies/fly-swatter.png'));
    deadSprite = Sprite('enemies/fly-swatter-dead.png');
  }

}