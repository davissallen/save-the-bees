import 'package:area51/game/collision/collision_box.dart';
import 'package:area51/game/obstacle/obstacle.dart';
import 'package:area51/game/hero/config.dart';
import 'package:area51/game/hero/hero.dart';

bool checkForCollision(Obstacle obstacle, Hero hero) {
  CollisionBox heroBox = CollisionBox(
    x: hero.x + 1,
    y: hero.y + 1,
    width: HeroConfig.width - 2,
    height: HeroConfig.height - 2,
  );

  CollisionBox obstacleBox = CollisionBox(
    x: obstacle.x + 1,
    y: obstacle.y + 1,
    width: obstacle.type.width * obstacle.internalSize - 2,
    height: obstacle.type.height - 2,
  );

  if (boxCompare(heroBox, obstacleBox)) {
    List<CollisionBox> collisionBoxes = obstacle.collisionBoxes;
    List<CollisionBox> heroCollisionBoxes =
        hero.ducking ? HeroCollisionBoxes.ducking : HeroCollisionBoxes.running;

    bool crashed = false;

    collisionBoxes.forEach((obstacleCollisionBox) {
      CollisionBox adjObstacleBox =
          createAdjustedCollisionBox(obstacleCollisionBox, obstacleBox);

      heroCollisionBoxes.forEach((tRexCollisionBox) {
        CollisionBox adjTRexBox =
            createAdjustedCollisionBox(tRexCollisionBox, heroBox);
        crashed = crashed || boxCompare(adjTRexBox, adjObstacleBox);
      });
    });
    return crashed;
  }
  return false;
}

bool boxCompare(CollisionBox heroBox, CollisionBox obstacleBox) {
  final double obstacleX = obstacleBox.x;
  final double obstacleY = obstacleBox.y;

  return (heroBox.x < obstacleX + obstacleBox.width &&
      heroBox.x + heroBox.width > obstacleX &&
      heroBox.y < obstacleBox.y + obstacleBox.height &&
      heroBox.height + heroBox.y > obstacleY);
}

CollisionBox createAdjustedCollisionBox(
    CollisionBox box, CollisionBox adjustment) {
  return CollisionBox(
      x: box.x + adjustment.x,
      y: box.y + adjustment.y,
      width: box.width,
      height: box.height);
}
