import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:save_the_bees/save_the_bees_game.dart';

class Enemy {
  final SaveTheBeesGame game;
  Rect enemyRect;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;

  Enemy(this.game, double x, double y) {
    enemyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
  }

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, enemyRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()]
          .renderRect(c, enemyRect.inflate(2));
    }
  }

  void update(double t) {
    if (enemyRect.top > game.screenSize.height) {
      isOffScreen = true;
    }

    if (isDead) {
      enemyRect = enemyRect.translate(0, game.tileSize * 3 * t);
    }
  }

  void onTapDown() {
    isDead = true;
  }
}
