import 'package:flutter/material.dart';
import 'package:langlaw/langlaw_game.dart';

class HighScoreDisplay {
  final LangLawGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  HighScoreDisplay(this.game) {
    painter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    Shadow shadow = Shadow(
      offset: Offset(3, 3),
      color: Color(0xff000000),
      blurRadius: 3,
    );

    textStyle = TextStyle(
        color: Color(0xffffffff),
        fontSize: 30,
        shadows: [shadow, shadow, shadow, shadow]);

    position = Offset.zero;
    updateHighScore();
  }

  void updateHighScore() {
    int highScore = game.storage.getInt('highScore') ?? 0;

    painter.text = TextSpan(
      text: 'High Score: ' + highScore.toString(),
      style: textStyle,
    );

    painter.layout();
    
    position = Offset(
      game.screenSize.width - (game.tileSize *0.25) - painter.width,
      game.tileSize * 0.25,
    );
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }
}
