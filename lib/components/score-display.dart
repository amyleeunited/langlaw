import 'package:flutter/cupertino.dart';
import 'package:langlaw/langlaw_game.dart';

class ScoreDisplay {
  final LangLawGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  ScoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textStyle =
        TextStyle(fontSize: 90.0, color: Color(0xffffffff), shadows: <Shadow>[
      Shadow(
        color: Color(0xff000000),
        blurRadius: 7,
        offset: Offset(3, 3),
      )
    ]);
    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text?.toPlainText() ?? '') != game.score.toString()) {
      painter.text = TextSpan(
        text: game.score.toString(),
        style: textStyle,
      );
      painter.layout();

      position = Offset(
        (game.screenSize.width / 2) - (painter.width / 2),
        (game.screenSize.height * 0.25) - (painter.height / 2),
      );
    }
  }
}
