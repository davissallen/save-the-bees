import 'dart:math';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:save_the_bees/components/hero.dart';
import 'package:save_the_bees/components/bee.dart';
import 'package:save_the_bees/components/enemy.dart';
import 'package:save_the_bees/components/background.dart';
import 'package:save_the_bees/components/pesticide.dart';
import 'package:save_the_bees/components/bee_eater.dart';
import 'package:save_the_bees/components/soap.dart';
import 'package:save_the_bees/components/fly_swatter.dart';
import 'package:save_the_bees/controllers/cloud_spawner.dart';
import 'package:save_the_bees/view.dart';
import 'package:save_the_bees/views/credits_view.dart';
import 'package:save_the_bees/views/help_view.dart';
import 'package:save_the_bees/views/home.dart';
import 'package:save_the_bees/components/start_button.dart';
import 'package:save_the_bees/views/loser.dart';
import 'package:save_the_bees/controllers/enemy_spawner.dart';
import 'package:save_the_bees/components/cloud.dart';
import 'package:save_the_bees/components/help_button.dart';
import 'package:save_the_bees/components/credits_button.dart';
import 'package:save_the_bees/components/score_display.dart';
import 'package:save_the_bees/components/high_score_display.dart';

class SaveTheBeesGame extends Game {
  Size screenSize;
  double tileSize;
  List<Enemy> enemies;
  Random random;
  Background background;
  Hero hero;
  Offset center;
  View activeView = View.home;
  HomeView homeView;
  StartButton startButton;
  LoserView loserView;
  EnemySpawner enemySpawner;
  List<Cloud> clouds;
  CloudSpawner cloudSpawner;
  HelpButton helpButton;
  CreditsButton creditsButton;
  HelpView helpView;
  CreditsView creditsView;
  int score;
  ScoreDisplay scoreDisplay;
  SharedPreferences storage;
  HighscoreDisplay highscoreDisplay;
  AudioPlayer backgroundMusic;
  bool backgroundMusicIsPlaying = false;

  SaveTheBeesGame(storage) {
    this.initialize();
    this.storage = storage;
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

  void initialize() async {
    random = new Random();
    enemies = List<Enemy>();
    resize(await Flame.util.initialDimensions());
    background = Background(this);
    homeView = HomeView(this);
    startButton = StartButton(this);
    loserView = LoserView(this);
    clouds = List<Cloud>();
    cloudSpawner = CloudSpawner(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
//    creditsView = CreditsView(this);  TODO
//    helpView = HelpView(this);  TODO
    score = 0;
    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);
    backgroundMusic = await Flame.audio.loop('music/bensound-summer.mp3', volume: 0.25);
    playBackgroundMusic();
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

  void update(double t) {
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
}
