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

  double outOfBounds = 200;

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
    tileSize = screenSize.width / Background.widthInTiles;
  }

  void spawnEnemy() {

    Offset spawnLocation = getSpawnLocation();

    double randomX = random.nextDouble() *
        (screenSize.width - (tileSize * 1.5 * BeeEater.relativeSize));
    double randomY = random.nextDouble() *
        (screenSize.height - (tileSize * 1.5 * BeeEater.relativeSize));

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
    hero = Bee(this, (screenSize.width - tileSize) / 2,
        (screenSize.height - tileSize) / 2);
  }

  // TODO Kjd;lkjf;kla BeeEater
  /// Returns X, Y in these ranges:
  ///   Range 1:
  ///     x: [-OOB, -ENEMY_WIDTH], y: [-OOB, SCREEN_HEIGHT+OOB]
  ///   Range 2:
  ///     x: [-OOB, SCREEN_WIDTH+OOB], y: [-OOB, -ENEMY_HEIGHT]
  ///   Range 3:
  ///     x: [SCREEN_WIDTH+ENEMY_WIDTH, SCREEN_WIDTH+OOB], y: [-OOB, SCREEN_HEIGHT+OOB]
  ///   Range 4:
  ///     x: [-OOB, SCREEN_WIDTH+OOB], y: [SCREEN_HEIGHT+ENEMY_HEIGHT, SCREEN_HEIGHT+OOB]
  Offset getSpawnLocation() {
    double x;
    double y;
    int area = random.nextInt(4);
    switch (area) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }
    Offset coordinates = Offset(x, y);
  }
}
