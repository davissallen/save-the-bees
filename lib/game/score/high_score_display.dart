import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:save_the_bees/save_the_bees_game.dart';

class HighscoreDisplay {
  final SaveTheBeesGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  HighscoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    Shadow shadow = Shadow(
      blurRadius: 1,
      color: Colors.black87,
      offset: Offset.zero,
    );

    textStyle = TextStyle(
      color: Colors.grey.shade700,
      fontSize: 24,
      fontFamily: 'munro',
      shadows: [shadow, shadow, shadow, shadow],
    );

    position = Offset.zero;

    updateHighscore();
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void updateHighscore() {
    int highscore = game.storage.getInt('highscore') ?? 0;

    painter.text = TextSpan(
      text: 'High Score: ' + highscore.toString(),
      style: textStyle,
    );

    painter.layout();

    position = Offset(16, 16);
  }
}
