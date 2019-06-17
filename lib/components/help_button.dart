import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:save_the_bees/save_the_bees_game.dart';
import 'package:save_the_bees/view.dart';

class HelpButton {
  final SaveTheBeesGame game;
  Rect rect;
  Sprite sprite;

  HelpButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize / 3.5,
      game.screenSize.height - (game.tileSize * 0.8),
      game.tileSize / 2,
      game.tileSize / 2,
    );
    sprite = Sprite('menu/help.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    // TODO
//    game.activeView = View.help;
  }
}