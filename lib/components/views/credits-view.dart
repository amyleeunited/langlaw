import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:langlaw/langlaw_game.dart';

class CreditsView {
  final LangLawGame game;
  Sprite creditsSprite;
  Rect creditsRect;

  CreditsView(this.game){
    creditsRect = Rect.fromLTWH(
    game.tileSize * 0.5, 
    (game.screenSize.height / 2) - 6 * game.tileSize,
    8 * game.tileSize, 
    12 * game.tileSize);

    creditsSprite = Sprite('ui/dialog-credits.png');
  }

  void render (Canvas c) {
    creditsSprite.renderRect(c, creditsRect);
  }
}