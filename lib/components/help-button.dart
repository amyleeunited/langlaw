import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:langlaw/langlaw_game.dart';
import 'package:flutter/gestures.dart';
import 'package:langlaw/view.dart';

class HelpButton{
  final LangLawGame game;
  Sprite helpBtnSprite;
  Rect helpBtnRect;

  HelpButton(this.game){
    helpBtnRect = Rect.fromLTWH(
      game.tileSize * 0.25, 
      game.screenSize.height - game.tileSize * 1.25, 
      game.tileSize, 
      game.tileSize);
    helpBtnSprite = Sprite('ui/icon-help.png');
  }

  void render(Canvas c) {
    helpBtnSprite.renderRect(c, helpBtnRect);

  }

  void onTapDown (TapDownDetails t){
    game.activeView = View.help;
  }
}