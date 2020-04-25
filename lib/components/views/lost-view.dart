import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:langlaw/langlaw_game.dart';

class LostView{
  final LangLawGame game;
  Sprite loseSprite;
  Rect loseRect;

  LostView(this.game){
    loseRect = Rect.fromLTWH(
      game.tileSize, 
      ((game.screenSize.height / 2) - (game.tileSize * 5)), 
      game.tileSize * 7, 
      game.tileSize * 5,
      );
      loseSprite = Sprite('bg/lose-splash.png');
  }

  void render (Canvas c) {
    loseSprite.renderRect(c, loseRect);
  }

  void update (double t) {

  }
}