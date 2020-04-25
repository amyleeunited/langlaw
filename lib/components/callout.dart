import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:langlaw/components/fly.dart';
import 'package:langlaw/view.dart';
import 'package:flame/flame.dart';

class CallOut {
  final Fly fly;
  Sprite sprite;
  Rect rect;
  double value;

  TextPainter tp;
  TextStyle textStyle;
  Offset txtOffset;

  CallOut(this.fly) {
    sprite = Sprite('ui/callout.png');
    value = 1;
    tp = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textStyle = TextStyle(
      color: Color(0xff000000),
      fontSize: 15,
    );
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    tp.paint(c, txtOffset);
  }

  void update(double t) {
    if (fly.game.activeView == View.playing) {
      value = value - (0.5 * t);
      if (value <= 0) {
        if (fly.game.soundButton.isEnabled){
          Flame.audio.play('sfx/haha' + (fly.game.rnd.nextInt(5) + 1).toString() + '.mp3');

        }
        fly.game.activeView = View.lost;
        fly.game.playHomeBGM();
      }
    }
    rect = Rect.fromLTWH(
      fly.flyRect.left - (fly.game.tileSize * 0.25),
      fly.flyRect.top - (fly.game.tileSize * 0.5),
      fly.game.tileSize * 0.75,
      fly.game.tileSize * 0.75,
    );

    tp.text = TextSpan(
      style: textStyle,
      text: (value * 10).toInt().toString(),
    );
    tp.layout();
    txtOffset = Offset(
      rect.center.dx - (tp.width / 2),
      rect.top + (rect.height * 0.4) - (tp.height / 2),
    );
  }
}
