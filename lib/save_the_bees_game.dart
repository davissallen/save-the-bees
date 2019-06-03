import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

import 'package:save_the_bees/components/hero.dart';
import 'package:save_the_bees/components/bee.dart';
import 'package:save_the_bees/components/enemy.dart';
import 'package:save_the_bees/components/background.dart';
import 'package:save_the_bees/components/pesticide.dart';
import 'package:save_the_bees/components/bee_eater.dart';
import 'package:save_the_bees/components/soap.dart';
import 'package:save_the_bees/components/fly_swatter.dart';

class SaveTheBeesGame extends Game {
  Size screenSize;
  double tileSize;
  List<Enemy> enemies;
  List<Enemy> enemiesInQueue;
  Random random;
  Background background;
  Hero hero;

  SaveTheBeesGame() {
    this.initialize();
  }

  void initialize() async {
    random = new Random();
    enemies = List<Enemy>();
    enemiesInQueue = List<Enemy>();
    resize(await Flame.util.initialDimensions());
    background = Background(this);
    spawnEnemy();
    spawnHero();
  }

  void render(Canvas canvas) {
    background.render(canvas);
    enemies.forEach((Enemy e) => e.render(canvas));
    hero.render(canvas);
  }

  void update(double t) {
    enemies.forEach((Enemy e) => e.update(t));
    enemies.removeWhere((Enemy e) => e.isOffScreen);
    hero.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 3;
  }

  void spawnEnemy() {
    double randomX = random.nextDouble() * (screenSize.width - tileSize);
    double randomY = random.nextDouble() * (screenSize.height - tileSize);

    Enemy e;
    switch (random.nextInt(4)) {
      case 0:
        e = Pesticide(this, randomX, randomY);
        break;
      case 1:
        e = Soap(this, randomX, randomY);
        break;
      case 2:
        e = BeeEater(this, randomX, randomY);
        break;
      case 3:
        e = FlySwatter(this, randomX, randomY);
        break;
    }

    if (enemies.length == 0) {
      enemies.add(e);
    } else {
      enemiesInQueue.add(e);
    }
  }

  void onTapDown(TapDownDetails d) {
    enemies.forEach((Enemy e) {
      if (!e.isDead && e.enemyRect.contains(d.globalPosition)) {
        e.onTapDown();
        spawnEnemy();
      }
    });
    enemies.addAll(enemiesInQueue);
    enemiesInQueue = List<Enemy>();

    if (hero.heroRect.contains(d.globalPosition)) {
      hero.onTapDown();
    }
  }

  void spawnHero() {
    hero = Bee(this, (screenSize.width - tileSize)/2, (screenSize.height - tileSize)/2);
  }
}
