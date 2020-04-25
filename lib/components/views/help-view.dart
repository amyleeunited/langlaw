import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:langlaw/langlaw_game.dart';

class HelpView {
  final LangLawGame game;
  Sprite helpSprite;
  Rect helpRect;

  HelpView(this.game){
    helpRect = Rect.fromLTWH(
    game.tileSize * 0.5, 
    (game.screenSize.height / 2) - 6 * game.tileSize,
    8 * game.tileSize, 
    12 * game.tileSize);

    helpSprite = Sprite('ui/dialog-help.png');
  }

  void render (Canvas c) {
    helpSprite.renderRect(c, helpRect);
  }
}