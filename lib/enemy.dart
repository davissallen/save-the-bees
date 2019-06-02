import 'dart:ui';

import 'package:save_the_bees/save_the_bees_game.dart';

class Enemy {
  final SaveTheBeesGame game;
  Rect enemyRect;
  Paint enemyPaint;
  bool isDead = false;
  bool isOffScreen = false;

  Enemy(this.game, double x, double y) {
    enemyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    enemyPaint = Paint()..color = Color(0xff6ab04c);
  }

  void render(Canvas c) {
    c.drawRect(enemyRect, enemyPaint);
  }

  void update(double t) {

    if (enemyRect.top > game.screenSize.height) {
      isOffScreen = true;
    }

    if (isDead) {
      enemyRect = enemyRect.translate(0, game.tileSize * 12 * t);
    }
  }

  void onTapDown() {
    isDead = true;
    enemyPaint.color = Color(0xffff4757);
    game.spawnEnemy();
  }
}
