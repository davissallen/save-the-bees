import 'package:flame/sprite.dart';

import 'package:save_the_bees/components/enemy.dart';
import 'package:save_the_bees/save_the_bees_game.dart';

class Pesticide extends Enemy {
  Pesticide(SaveTheBeesGame game, double x, double y) : super(game, x, y) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('pesticide.png'));
    deadSprite = Sprite('pesticide-dead.png');
  }

}