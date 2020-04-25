import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:langlaw/langlaw_game.dart';
import 'package:langlaw/view.dart';

class StartButton{
  final LangLawGame game;
  Sprite startSprite;
  Rect startRect;
  View startview;

  StartButton(this.game){
    startRect = Rect.fromLTWH(
      game.tileSize * 1.5, 
      (game.screenSize.height / 2) + (2.5 * game.tileSize), 
      6 * game.tileSize, 
      3 * game.tileSize);

    startSprite = Sprite('ui/start-button.png');
  }

  void render(Canvas c){
    startSprite.renderRect(c, startRect);


  }

  void update(double t) {

  }

  void onTapDown ( TapDownDetails d) {
    game.activeView = View.playing;
    game.spawner.start();
    game.score = 0;
    game.playPlayingBGM();
    

  }
}