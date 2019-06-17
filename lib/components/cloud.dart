import 'dart:math';
import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:save_the_bees/save_the_bees_game.dart';

class Cloud {

  final SaveTheBeesGame game;
  bool isOffScreen = false;
  Offset targetLocation;
  Rect cloudRect;
  double speed;
  Sprite cloudSprite;
  final Random random = new Random();
  double maxSpeed = 2;
  double minSpeed = 1.5;
  double relativeSize;

  Cloud(this.game) {
    this.maxSpeed *= game.tileSize;
    this.minSpeed *= game.tileSize;
    this.relativeSize = random.nextDouble() * (1.1 - 0.4) + 0.4;
    double randomHeight = random.nextDouble() * (game.screenSize.height - (3 * game.tileSize));
    cloudRect = Rect.fromLTWH(
      this.game.screenSize.width,
      randomHeight,
      game.tileSize * 2 * relativeSize,
      game.tileSize * relativeSize,
    );
    speed = random.nextDouble() * (maxSpeed - minSpeed);
    cloudSprite = Sprite('bg/cloud.png');

    setTargetLocation();
  }

  void render(Canvas c) {
    cloudSprite.renderRect(c, cloudRect);
  }

  void update(double t) {
    if (cloudRect.right < 0) {
      isOffScreen = true;
    }

    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(cloudRect.left, cloudRect.top);
    Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
    cloudRect = cloudRect.shift(stepToTarget);


  }

  void setTargetLocation() {
    targetLocation = Offset(-cloudRect.width, cloudRect.top);
  }

}