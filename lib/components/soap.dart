import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:save_the_bees/components/enemy.dart';
import 'package:save_the_bees/save_the_bees_game.dart';

class Soap extends Enemy {
  static final double relativeSize = 1;

  double get speed => game.tileSize * 2;

  Soap(SaveTheBeesGame game, double x, double y) : super(game) {
    enemyRect = Rect.fromLTWH(
      x,
      y,
      game.tileSize * relativeSize,
      game.tileSize * relativeSize / 1.53,
    );    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('enemies/soap.png'));
    deadSprite = Sprite('enemies/soap-dead.png');
  }

}