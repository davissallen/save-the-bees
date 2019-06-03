import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:save_the_bees/save_the_bees_game.dart';
import 'package:save_the_bees/components/background.dart';

class Hero {
  final SaveTheBeesGame game;
  Rect heroRect;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  static final double gravity = Background.heightInTiles / 3;

  Hero(this.game, double x, double y) {
    heroRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
  }

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, heroRect.inflate(1));  // TODO experiment w this value.
    } else {
      flyingSprite[flyingSpriteIndex.toInt()]
          .renderRect(c, heroRect.inflate(1));
    }
  }

  void update(double t) {
    if (isDead) {
      if (heroRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
      heroRect = heroRect.translate(0, game.tileSize * gravity * t);
    } else {
      flyingSpriteIndex += 6 * t;  // TODO experiment w this value.
      if (flyingSpriteIndex >= flyingSprite.length) {
        flyingSpriteIndex -= flyingSprite.length;
      }
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
