import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:save_the_bees/save_the_bees_game.dart';

class LoserView {
  final SaveTheBeesGame game;
  Rect titleRect;
  Sprite titleSprite;

  LoserView(this.game) {
    titleRect = Rect.fromLTWH(
      game.tileSize / 3,
      (game.screenSize.height / 2) - (game.tileSize * 2),
      game.tileSize * 4,
      game.tileSize * 3,
    );
    titleSprite = Sprite('ui/lose.png');
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void update(double t) {}
}