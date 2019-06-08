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
      game.tileSize * relativeSize,
      game.tileSize * relativeSize,
    );
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('fly-swatter.png'));
    deadSprite = Sprite('fly-swatter-dead.png');
  }

}