import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import 'package:save_the_bees/save_the_bees_game.dart';
import 'package:save_the_bees/view.dart';

class Hero {
  final SaveTheBeesGame game;
  Rect heroRect;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  static const int wingFlapsPerSecond = 15;
  Offset targetLocation;

  double get speed => game.tileSize * 1.7;

  Hero(this.game, double x, double y) {
    heroRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    setTargetLocation();
    this.game.backgroundMusic.resume();
  }

  void setTargetLocation() {
    double x = game.random.nextDouble() * game.tileSize * 2 - 100;
    double y = game.random.nextDouble() * game.tileSize * 2 - 100;
    targetLocation =
        Offset(game.screenSize.width / 2 + x, game.screenSize.height / 2 + y);
  }

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, heroRect);
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, heroRect);
    }
  }

  void update(double t) {

    if (isDead) {
      if (heroRect.top > game.screenSize.height) {
        isOffScreen = true;
        game.endGame();
      }
      heroRect = heroRect.translate(0, game.tileSize * 3 * t);
      return;
    }

    flyingSpriteIndex += wingFlapsPerSecond * t;

    if (flyingSpriteIndex >= 2) {
      flyingSpriteIndex -= 2;
    }

    double stepDistance = speed * t;
    Offset toTarget = targetLocation - heroRect.center;

    if (stepDistance < toTarget.distance) {

      // If it can't be reached in one step.
      Offset step = Offset.fromDirection(toTarget.direction, stepDistance);
      heroRect = heroRect.shift(step);

    } else {

      // If it is less than one step away.
      heroRect = heroRect.shift(toTarget);
      setTargetLocation();

    }

  }

  void onTapDown() {
    // do nothing.
  }

  void die() {
    if (!isDead) {
      isDead = true;
      Flame.audio.play('sfx/die.wav');
      // Pause music.
      this.game.backgroundMusic.pause();
      // Flash screen.
      flashScreenOut();
      // Make enemies disappear.
      fadeAwayEnemies();
    }
  }

  void flashScreenOut() {
    // TODO: Implement me.
  }

  void fadeAwayEnemies() {
    // TODO: Implement me.
  }
}
