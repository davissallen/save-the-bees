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

  Hero(this.game, double x, double y) {
    heroRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
  }

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, heroRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()]
          .renderRect(c, heroRect.inflate(2));
    }
  }

  void update(double t) {
    if (isDead) {
      if (heroRect.top > game.screenSize.height) {
        isOffScreen = true;
        game.endGame();
      }
      heroRect = heroRect.translate(0, game.tileSize * 3 * t);
    } else {
      flyingSpriteIndex += wingFlapsPerSecond * t;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
    }
  }

  void onTapDown() {
    die();
  }

  void die() {
    if (!isDead) {
      isDead = true;
      Flame.audio.play('sfx/die.wav');
    }
  }
}
