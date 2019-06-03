import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:save_the_bees/save_the_bees_game.dart';

class Background {
  final SaveTheBeesGame game;
  Sprite bgSprite;
  Rect bgRect;

  Background(this.game) {
    bgSprite = Sprite('bg.png');
    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height - (game.tileSize * 6),
      game.tileSize * 3,
      game.tileSize * 6,
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}