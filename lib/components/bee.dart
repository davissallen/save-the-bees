import 'package:flame/sprite.dart';

import 'package:save_the_bees/components/hero.dart';
import 'package:save_the_bees/save_the_bees_game.dart';

class Bee extends Hero {
  Bee(SaveTheBeesGame game, double x, double y) : super(game, x, y) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('bee-1.png'));
    flyingSprite.add(Sprite('bee-2.png'));
    deadSprite = Sprite('bee-dead.png');
  }

}
