import 'dart:ui';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:save_the_bees/game/util/util.dart';

import 'package:save_the_bees/save_the_bees_game.dart';
import 'package:save_the_bees/view.dart';

enum HeroStatus { alive, dead }

class Hero extends PositionComponent with ComposedComponent, Resizable {
  HeroStatus status = HeroStatus.alive;

  AliveHero aliveHero;
  DeadHero deadHero;

  bool hasPlayedIntro;
  double wingFlapsPerSecond = 15.0;
  Offset targetLocation;
  double velocity = 100.0;

  Hero(Image spriteImage)
      : aliveHero = AliveHero(spriteImage),
        deadHero = DeadHero(spriteImage),
        super();

  PositionComponent get actualHero {
    switch (status) {
      case HeroStatus.alive:
        return aliveHero;
      case HeroStatus.dead:
        return deadHero;
      default:
        return aliveHero;
    }
  }

  @override
  void render(Canvas canvas) {
    this.actualHero.render(canvas);
  }

  void reset() {
    this.status = HeroStatus.alive;
    this.setTargetLocation();
  }

  void setTargetLocation() {
    double x = getRandomNum(0, 500);
    double y = getRandomNum(0, 1000);
    targetLocation = Offset(x, y);
  }

  void update(double t) {

    if (status == HeroStatus.dead) {
      // TODO: move off screen
    }

    double stepDistance = velocity * t;
    Offset toTarget = targetLocation - Offset(actualHero.x, actualHero.y);

    if (stepDistance < toTarget.distance) {
      // If it can't be reached in one step.
      Offset step = Offset.fromDirection(toTarget.direction, stepDistance);
      actualHero.x = step.dx;
      actualHero.y = step.dy;
    } else {
      setTargetLocation();
    }
  }

  void onTapDown() {
    // do nothing.
  }

  // TODO: Implement below in other section of code.
//  void die() {
//    if (!isDead) {
//      isDead = true;
//      Flame.audio.play('sfx/die.wav');
//      // Pause music.
//      this.game.backgroundMusic.pause();
//      // stop spawner.
//      this.game.enemySpawner.stop();
//      // Flash screen.
//      this.game.flashScreenOut();
//      // Make enemies disappear.
//      this.game.fadeAwayEnemies();
//    }
//  }
}

class AliveHero extends AnimationComponent {
  AliveHero(Image spriteImage)
      : super(
            82.0,
            104.0,
            Animation.spriteList([
              Sprite.fromImage(
                spriteImage,
                width: 82.0,
                height: 104.0,
                y: 16.0,
                x: 473.0,
              ),
              Sprite.fromImage(
                spriteImage,
                width: 82.0,
                height: 104.0,
                y: 16.0,
                x: 611,
              ),
            ], stepTime: 0.1, loop: true));
}

class DeadHero extends SpriteComponent {
  DeadHero(Image spriteImage)
      : super.fromSprite(
            82.0,
            104.0,
            Sprite.fromImage(
              spriteImage,
              width: 82.0,
              height: 104.0,
              x: 749.0,
              y: 28.0,
            ));
}
