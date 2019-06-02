import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

import 'package:save_the_bees/enemy.dart';
import 'package:save_the_bees/background.dart';

class SaveTheBeesGame extends Game {
  Size screenSize;
  double tileSize;
  List<Enemy> enemies;
  Random randomGenerator;
  Background background;

  SaveTheBeesGame() {
    this.initialize();
  }

  void initialize() async {
    randomGenerator = new Random();
    enemies = List<Enemy>();
    background = Background(this);
    resize(await Flame.util.initialDimensions());
    spawnEnemy();
  }

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);

    enemies.forEach((Enemy e) => e.render(canvas));

    background.render(canvas);
  }

  void update(double t) {
    enemies.forEach((Enemy e) => e.update(t));
    enemies.removeWhere((Enemy e) => e.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void spawnEnemy() {
    double randomX = randomGenerator.nextDouble() * (screenSize.width - tileSize);
    double randomY = randomGenerator.nextDouble() * (screenSize.height - tileSize);
    enemies.add(Enemy(this, randomX, randomY));
  }

  void onTapDown(TapDownDetails d) {
    enemies.forEach((Enemy e) {
      if (e.enemyRect.contains(d.globalPosition)) {
        e.onTapDown();
      }
    });
  }

}
