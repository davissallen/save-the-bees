import 'dart:math';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:save_the_bees/game/hero/hero.dart';
import 'package:save_the_bees/game/enemy/bee.dart';
import 'package:save_the_bees/game/enemy/enemy.dart';
import 'package:save_the_bees/game/background/background.dart';
import 'package:save_the_bees/game/enemy/pesticide.dart';
import 'package:save_the_bees/game/enemy/bee_eater.dart';
import 'package:save_the_bees/game/enemy/soap.dart';
import 'package:save_the_bees/game/enemy/fly_swatter.dart';
import 'package:save_the_bees/game/background/cloud_spawner.dart';
import 'package:save_the_bees/view.dart';
import 'package:save_the_bees/views/credits_view.dart';
import 'package:save_the_bees/views/help_view.dart';
import 'package:save_the_bees/views/home.dart';
import 'package:save_the_bees/components/start_button.dart';
import 'package:save_the_bees/views/loser.dart';
import 'package:save_the_bees/game/enemy/enemy_spawner.dart';
import 'package:save_the_bees/game/background/cloud.dart';
import 'package:save_the_bees/components/help_button.dart';
import 'package:save_the_bees/components/credits_button.dart';
import 'package:save_the_bees/game/score/score_display.dart';
import 'package:save_the_bees/game/score/high_score_display.dart';

enum SaveTheBeesGameStatus { playing, waiting, gameOver }

class SaveTheBeesGame extends BaseGame {

  Hero hero;
  Background background;
  ScoreDisplay scoreDisplay;
  GameOverDisplay gameOverDisplay;
  SaveTheBeesGameStatus status = SaveTheBeesGameStatus.waiting;
  SharedPreferences storage;
  AudioPlayer backgroundMusic;
  double score = 0;

  bool get playing => status == SaveTheBeesGameStatus.playing;
  bool get waiting => status == SaveTheBeesGameStatus.waiting;
  bool get gameOver => status == SaveTheBeesGameStatus.gameOver;

//  Size screenSize;
//  double tileSize;
//  List<Enemy> enemies;
//  Random random;
//  Background background;
//  Hero hero;
//  Offset center;
//  View activeView = View.home;
//  HomeView homeView;
//  StartButton startButton;
//  LoserView loserView;
//  EnemySpawner enemySpawner;
//  List<Cloud> clouds;
//  CloudSpawner cloudSpawner;
//  HelpButton helpButton;
//  CreditsButton creditsButton;
//  HelpView helpView;
//  CreditsView creditsView;
//  int score;
//  ScoreDisplay scoreDisplay;
//  HighscoreDisplay highscoreDisplay;
//  bool backgroundMusicIsPlaying = false;

  SaveTheBeesGame(storage, {spriteSheetImage, backgroundImage}) {
    // Start the music player and other startup functions. Since this is an
    // asynchronout function, it must be called outside of the constructor.
    initialize();

    // hold reference to persistent storage
    this.storage = storage;

    // create displays
    this.hero = new Hero(spriteSheetImage);
    this.background = new Background(backgroundImage, spriteSheetImage);
//    this.scoreDisplay = new Hero(spriteSheetImage);
//    this.gameOverDisplay = new Hero(spriteSheetImage);

    // add components to main game
    this..add(hero)..add(background);
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        playBackgroundMusic();
        break;
      case AppLifecycleState.inactive:
        pauseBackgroundMusic();
        break;
      case AppLifecycleState.paused:
        pauseBackgroundMusic();
        break;
      case AppLifecycleState.suspending:
        break;
    }
  }

  void onTap() {
    // kill enemies?
  }

  void initialize() async {
    backgroundMusic = await Flame.audio.loop('music/bensound-summer.mp3', volume: 0.25);
    playBackgroundMusic();  // do i need this here?
  }

  void update(double t) {

    hero.update(t);
    background.update(t);

    if (gameOver) return;

    if (playing) {

    }


    if (cloudSpawner != null) {
      cloudSpawner.update(t);
      clouds.forEach((Cloud c) => c.update(t));
      clouds.removeWhere((Cloud c) => c.isOffScreen);
    }

    if (activeView == View.playing) {
      enemySpawner.update(t);
      enemies.forEach((Enemy e) => e.update(t));
      enemies.removeWhere((Enemy e) => e.isOffScreen);
      hero.update(t);
      scoreDisplay.update(t);
    }
  }

  void render(Canvas canvas) {
    background.render(canvas);
    clouds.forEach((Cloud c) => c.render(canvas));

    switch (activeView) {

      case View.home:
        homeView.render(canvas);
        startButton.render(canvas);
        helpButton.render(canvas);
        creditsButton.render(canvas);
        break;

      case View.playing:
        hero.render(canvas);
        enemies.forEach((Enemy e) => e.render(canvas));
        scoreDisplay.render(canvas);
        break;

      case View.lost:
        loserView.render(canvas);
        startButton.render(canvas);
        break;

      case View.help:
        break;

      case View.credits:
        // TODO: Handle this case.
        break;
    }

    highscoreDisplay.render(canvas);

  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / Background.widthInTiles;
    center = Offset(
      (size.width - tileSize) / 2,
      (size.height - tileSize) / 2,
    );
  }

  void spawnEnemy() {
    //spawn from 1 of 4 corners.
    int randomCorner = random.nextInt(4);

    double x, y;

    switch (randomCorner) {
      case 0:
        x = 0;
        y = 0;
        break;
      case 1:
        x = screenSize.width - tileSize;
        y = 0;
        break;
      case 2:
        x = screenSize.width - tileSize;
        y = screenSize.height - tileSize;
        break;
      case 3:
        x = 0;
        y = screenSize.height - tileSize;
        break;
    }

    Enemy e;
    switch (random.nextInt(4)) {
      case 0:
        e = Pesticide(this, x, y);
        break;
      case 1:
        e = Soap(this, x, y);
        break;
      case 2:
        e = BeeEater(this, x, y);
        break;
      case 3:
        e = FlySwatter(this, x, y);
        break;
    }

    enemies.add(e);
  }

  void onTapDown(TapDownDetails d) {
    switch (activeView) {

      case View.playing:
        enemies.forEach((Enemy e) {
          if (!e.isDead && e.enemyRect.contains(d.globalPosition)) {
            e.onTapDown();
          }
        });
        if (hero.heroRect.contains(d.globalPosition)) hero.onTapDown();
        break;

      case View.home:
        if (startButton.rect.contains(d.globalPosition)) {
          startButton.onTapDown();
        }
        if (helpButton.rect.contains(d.globalPosition)) {
          helpButton.onTapDown();
        }
        if (creditsButton.rect.contains(d.globalPosition)) {
          creditsButton.onTapDown();
        }

        break;

      case View.lost:
        if (startButton.rect.contains(d.globalPosition)) {
          startButton.onTapDown();
        }
        break;
      case View.help:
        break;
      case View.credits:
        // TODO: Handle this case.
        break;
    }

  }

  void spawnHero() {
    hero = Bee(this, center.dx, center.dy);
  }

  void endGame() {
    this.activeView = View.lost;
  }

  void startGame() {
    this.score = 0;
    this.enemySpawner = EnemySpawner(this);
    this.hero = null;
    spawnHero();
    this.activeView = View.playing;
  }

  void spawnCloud() {
    this.clouds.add(Cloud(this));
  }

  void playBackgroundMusic({bool fromBeginning = false}) {
    if (backgroundMusic != null) {
      if (fromBeginning) {
        backgroundMusic.seek(Duration.zero);
      }
      backgroundMusic.resume();
      backgroundMusicIsPlaying = true;
    }
  }

  void pauseBackgroundMusic() {
    if (backgroundMusic != null && backgroundMusicIsPlaying) {
      backgroundMusic.pause();
    }
  }

  void flashScreenOut() {
    // TODO: Implement me.
  }

  void fadeAwayEnemies() {
    enemies.forEach((Enemy e) {
      e.fadeAway();
    });
  }
}
