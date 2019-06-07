import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:save_the_bees/components/enemy.dart';
import 'package:save_the_bees/save_the_bees_game.dart';

class Soap extends Enemy {
  static final double relativeSize = 1;

  Soap(SaveTheBeesGame game, double x, double y) : super(game) {
    enemyRect = Rect.fromLTWH(
      x,
      y,
      game.tileSize * (1.5 * relativeSize),
      game.tileSize * 1.5,
    );    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('soap.png'));
    deadSprite = Sprite('soap-dead.png');
  }

}