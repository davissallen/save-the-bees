import 'dart:math';

import 'package:save_the_bees/save_the_bees_game.dart';

class CloudSpawner {
  final SaveTheBeesGame game;
  final int maxSpawnInterval = 6000;
  final int minSpawnInterval = 2000;
  int nextSpawn;
  final Random random = Random();
  final int maxCloudsOnScreen = 5;

  CloudSpawner(this.game) {
    nextSpawn = DateTime.now().millisecondsSinceEpoch;
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    if (nowTimestamp >= nextSpawn && game.clouds.length < maxCloudsOnScreen) {
      game.spawnCloud();
      nextSpawn = random.nextInt(maxSpawnInterval - minSpawnInterval) + minSpawnInterval + nowTimestamp;
    }
  }

}