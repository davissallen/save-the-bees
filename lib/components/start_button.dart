import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:save_the_bees/save_the_bees_game.dart';
import 'package:save_the_bees/view.dart';

class StartButton {
  final SaveTheBeesGame game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      game.screenSize.height - (game.tileSize * 3),
      game.tileSize * 2,
      game.tileSize * 1,
    );
    sprite = Sprite('ui/start.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void onTapDown() {
    this.game.startGame();
  }
}
