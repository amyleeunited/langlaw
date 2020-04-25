import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:langlaw/langlaw_game.dart';

class HomeView{
  final LangLawGame game;
  Rect titleRect;
  Sprite titleSprite;

  HomeView(this.game) {
    titleRect = Rect.fromLTWH(
      game.tileSize, 
      (game.screenSize.height / 2) - (game.tileSize * 4), 
      7* game.tileSize, 
      4 * game.tileSize);

    titleSprite = Sprite('branding/title.png');
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void update(double t) {

  }
}