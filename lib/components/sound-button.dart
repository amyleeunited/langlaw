import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:langlaw/langlaw_game.dart';

class SoundButton {
  final LangLawGame game;
  Sprite enabledSprite;
  Sprite disabledSprite;
  Rect rect;
  bool isEnabled = true;

  SoundButton(this.game){
    rect = Rect.fromLTWH(
      (game.tileSize * 0.5) + game.tileSize, 
      game.tileSize * 0.25, 
      game.tileSize, 
      game.tileSize);
    enabledSprite = Sprite('ui/icon-sound-enabled.png');
    disabledSprite = Sprite('ui/icon-sound-disabled.png');

  }

  void render (Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void onTapDown (TapDownDetails d) {
    if (isEnabled) {
      isEnabled = !isEnabled;
    } else {
      isEnabled = true;
    }
  }
}