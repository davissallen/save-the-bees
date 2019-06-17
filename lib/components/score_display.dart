import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:save_the_bees/save_the_bees_game.dart';

class ScoreDisplay {
  final SaveTheBeesGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  ScoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 80,
      fontFamily: 'munro',
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(1, 1),
        ),
      ],
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text?.text ?? '') != game.score.toString()) {
      painter.text = TextSpan(
        text: game.score.toString(),
        style: textStyle,
      );

      painter.layout();

      position = Offset(
        (game.screenSize.width / 2) - (painter.width / 2),
        16,
      );
    }
  }

}