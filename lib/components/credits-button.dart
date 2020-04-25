import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:langlaw/langlaw_game.dart';
import 'package:langlaw/view.dart';

class CreditsButton{
  final LangLawGame game;
  Sprite sprite;
  Rect rect;

  CreditsButton(this.game){
    rect = Rect.fromLTWH(
      game.screenSize.width - (game.tileSize * 1.25), 
      game.screenSize.height - (game.tileSize * 1.25), 
      game.tileSize, 
      game.tileSize);

      sprite = Sprite('ui/icon-credits.png');
  }

  void render(Canvas c){
    sprite.renderRect(c, rect);
  }

  void onTapDown(TapDownDetails d){
    game.activeView = View.credits;
  }
}