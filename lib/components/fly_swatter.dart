import 'package:flame/sprite.dart';

import 'package:save_the_bees/components/enemy.dart';
import 'package:save_the_bees/save_the_bees_game.dart';

class FlySwatter extends Enemy {
  FlySwatter(SaveTheBeesGame game, double x, double y) : super(game, x, y) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('fly-swatter.png'));
    deadSprite = Sprite('fly-swatter.png');  // TODO: Make dead image?
  }

}