import 'package:flame/sprite.dart';

import 'package:save_the_bees/components/enemy.dart';
import 'package:save_the_bees/save_the_bees_game.dart';

class Soap extends Enemy {
  Soap(SaveTheBeesGame game, double x, double y) : super(game, x, y) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('soap.png'));
    deadSprite = Sprite('soap.png');  // TODO: Make dead image?
  }

}