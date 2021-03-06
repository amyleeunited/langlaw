import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:langlaw/components/fly.dart';
import 'package:langlaw/langlaw_game.dart';

class HouseFly extends Fly{
  HouseFly(LangLawGame game, double x, double y) : super(game){
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('flies/house-fly-1.png'));
    flyingSprite.add(Sprite('flies/house-fly-2.png'));
    deadSprite = Sprite('flies/house-fly-dead.png');
  }

}