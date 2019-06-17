import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:save_the_bees/save_the_bees_game.dart';
import 'package:save_the_bees/view.dart';

class CreditsButton {
  final SaveTheBeesGame game;
  Rect rect;
  Sprite sprite;

  CreditsButton(this.game) {
    rect = Rect.fromLTWH(
      game.screenSize.width - (game.tileSize * 0.75),
      game.screenSize.height - (game.tileSize * 0.85),
      game.tileSize / 2,
      game.tileSize / 2,
    );
    sprite = Sprite('menu/credits.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    // TODO
//    game.activeView = View.credits;
  }
}