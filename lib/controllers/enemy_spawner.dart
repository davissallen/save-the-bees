import 'package:save_the_bees/save_the_bees_game.dart';
import 'package:save_the_bees/components/enemy.dart';

class EnemySpawner {
  final SaveTheBeesGame game;
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int intervalChange = 250;
  final int maxEnemies = 3;
  int currentInterval;
  int nextSpawn;

  EnemySpawner(this.game) {
    this.start();
    game.spawnEnemy();
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
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    int livingEnemies = 0;
    game.enemies.forEach((Enemy e) {
      if (!e.isDead) livingEnemies += 1;
    });

    if (nowTimestamp >= nextSpawn && livingEnemies < maxEnemies) {
      game.spawnEnemy();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }

}