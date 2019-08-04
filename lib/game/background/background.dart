import 'dart:ui';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:save_the_bees/game/background/config.dart';

import 'package:save_the_bees/save_the_bees_game.dart';

class Background extends PositionComponent with Resizable, ComposedComponent {
  SceneryManager sceneryManager;
  EnemyManager enemyManager;

  Realm1 realm1;
  Realm2 realm2;
  Realm3 realm3;
  Realm4 realm4;
  int currentRealm = 1;
  bool realmShouldIncrement = false;

  Background(Image spriteImage, Image backgroundImage) {
    this.realm1 = Realm1(backgroundImage);
    this.realm2 = Realm2(backgroundImage);
    this.realm3 = Realm3(backgroundImage);
    this.realm4 = Realm4(backgroundImage);
    currentRealm = 1;

    this.sceneryManager = SceneryManager(spriteImage);
    this.enemyManager = EnemyManager(spriteImage);

    this
      ..add(realm1)
      ..add(realm2)
      ..add(realm3)
      ..add(realm4)
      ..add(sceneryManager)
      ..add(enemyManager);
  }

  void render(Canvas c) {
    c.save();

    if (realmShouldIncrement) {
      currentRealm += 1;
      realmShouldIncrement = false;

      // do i need to un-render all previous realm drawings?
      switch (currentRealm) {
        case 1:
          this.realm1.render(c);
          break;
        case 2:
          this.realm2.render(c);
          break;
        case 3:
          this.realm3.render(c);
          break;
        case 4:
          this.realm4.render(c);
          break;
        default:
          this.realm4.render(c);
          break;
      }
    }

    this.sceneryManager.render(c);
    this.enemyManager.render(c);

    c.restore();
  }

  void update(double t) {
    super.update(t);
  }

  void reset() {
    sceneryManager.reset();
    enemyManager.reset();
    this.currentRealm = 1;
  }
}

class Realm1 extends SpriteComponent with Resizable {
  Realm1(Image backgroundImage)
      : super.fromSprite(
            BackgroundDimensions.width,
            BackgroundDimensions.height,
            Sprite.fromImage(
              backgroundImage,
              width: BackgroundDimensions.width,
              height: BackgroundDimensions.width,
              x: BackgroundDimensions.realm1X,
              y: BackgroundDimensions.realm1Y,
            ));
}

class Realm2 extends SpriteComponent with Resizable {
  Realm2(Image backgroundImage)
      : super.fromSprite(
            BackgroundDimensions.width,
            BackgroundDimensions.height,
            Sprite.fromImage(
              backgroundImage,
              width: BackgroundDimensions.width,
              height: BackgroundDimensions.width,
              x: BackgroundDimensions.realm2X,
              y: BackgroundDimensions.realm2Y,
            ));
}

class Realm3 extends SpriteComponent with Resizable {
  Realm3(Image backgroundImage)
      : super.fromSprite(
            BackgroundDimensions.width,
            BackgroundDimensions.height,
            Sprite.fromImage(
              backgroundImage,
              width: BackgroundDimensions.width,
              height: BackgroundDimensions.width,
              x: BackgroundDimensions.realm3X,
              y: BackgroundDimensions.realm3Y,
            ));
}

class Realm4 extends SpriteComponent with Resizable {
  Realm4(Image backgroundImage)
      : super.fromSprite(
            BackgroundDimensions.width,
            BackgroundDimensions.height,
            Sprite.fromImage(
              backgroundImage,
              width: BackgroundDimensions.width,
              height: BackgroundDimensions.width,
              x: BackgroundDimensions.realm4X,
              y: BackgroundDimensions.realm4Y,
            ));
}
