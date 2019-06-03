import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:save_the_bees/components/enemy.dart';
import 'package:save_the_bees/save_the_bees_game.dart';

class BeeEater extends Enemy {
  static final double relativeSize = 1.5;

  BeeEater(SaveTheBeesGame game, double x, double y) : super(game) {
    enemyRect = Rect.fromLTWH(
      x,
      y,
      game.tileSize * (1.5 * relativeSize),
      game.tileSize * (1.5 * relativeSize),
    );
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('bee-eater.png'));
    deadSprite = Sprite('bee-eater-dead.png');
  }
}
