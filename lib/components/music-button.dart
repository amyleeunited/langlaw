import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:langlaw/langlaw_game.dart';

class MusicButton {
  final LangLawGame game;
  Sprite enabledSprite;
  Sprite disabledSprite;
  Rect rect;
  bool isEnabled = true;

  MusicButton(this.game) {
    enabledSprite = Sprite('ui/icon-music-enabled.png');
    disabledSprite = Sprite('ui/icon-music-disabled.png');
    rect = Rect.fromLTWH(
      game.tileSize * 0.25,
      game.tileSize * 0.25,
      game.tileSize,
      game.tileSize,
    );
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void onTapDown(TapDownDetails d) {
    if (isEnabled) {
      isEnabled = false;
      game.homeBGM.setVolume(0);
      game.playingBGM.setVolume(0);
    } else {
      isEnabled = true;
      game.homeBGM.setVolume(0.25);
      game.playingBGM.setVolume(0.25);
    }
  }
}
