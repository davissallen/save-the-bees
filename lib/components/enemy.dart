import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:save_the_bees/components/background.dart';

import 'package:save_the_bees/save_the_bees_game.dart';

class Enemy {
  final SaveTheBeesGame game;
  Rect enemyRect;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  double gravity = Background.heightInTiles.toDouble();
  Offset targetLocation;

  double get speed => game.tileSize * 1.5;

  Enemy(this.game) {
    setTargetLocation();
  }

  void setTargetLocation() {
    targetLocation = game.center;
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
      enemyRect = enemyRect.translate(0, game.tileSize * gravity * t);
      return;
    }

    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(enemyRect.left, enemyRect.top);
    if (stepDistance < toTarget.distance) {
      // If it can't be reached in one step.
      Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
      enemyRect = enemyRect.shift(stepToTarget);
    } else {
      // If it is less than one step away.
      enemyRect = enemyRect.shift(toTarget);
      this.game.hero.die();
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
