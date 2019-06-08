import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:save_the_bees/save_the_bees_game.dart';

class Background {
  final SaveTheBeesGame game;
  Sprite bgSprite;
  Rect bgRect;
  static final int heightInTiles = 10;
  static final int widthInTiles = 5;

  Background(this.game) {
    bgSprite = Sprite('bg/bg.png');
    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height - (game.tileSize * heightInTiles),
      game.tileSize * widthInTiles,
      game.tileSize * heightInTiles,
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}