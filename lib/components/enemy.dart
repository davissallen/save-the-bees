import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:save_the_bees/components/background.dart';

import 'package:save_the_bees/save_the_bees_game.dart';

class Enemy {
  static final double gravity = Background.heightInTiles.toDouble();

  final SaveTheBeesGame game;
  Rect enemyRect;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;

  Enemy(this.game);

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, enemyRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()]
          .renderRect(c, enemyRect.inflate(2));
    }
  }

  void update(double t) {
    if (isDead) {
      if (enemyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
      enemyRect = enemyRect.translate(0, game.tileSize * 3 * t);
    } else {
      flyingSpriteIndex += 12 * t;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
    }
  }

  void onTapDown() {
    if (!isDead) {
      die();
    }
  }

  void die() {
    isDead = true;
  }
}
