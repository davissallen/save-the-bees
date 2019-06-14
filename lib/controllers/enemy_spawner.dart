import 'package:save_the_bees/save_the_bees_game.dart';
import 'package:save_the_bees/components/enemy.dart';

class EnemySpawner {
  final SaveTheBeesGame game;
  final int maxSpawnInterval = 2000;
  final int minSpawnInterval = 333;
  final int intervalChange = 100;
  final int maxEnemies = 3;
  int currentInterval;
  int nextSpawn;

  EnemySpawner(this.game) {
    this.start();
  }

  void start() {
    this.killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    game.enemies.clear();
  }

  void update(double t) {
    int now = DateTime.now().millisecondsSinceEpoch;

    int livingEnemies = 0;
    game.enemies.forEach((Enemy e) {
      if (!e.isDead) livingEnemies += 1;
    });

    if (now >= nextSpawn && livingEnemies < maxEnemies) {
      game.spawnEnemy();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
      }
      nextSpawn = now + currentInterval;
    }
  }

}