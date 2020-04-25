import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:langlaw/components/fly.dart';
import 'package:langlaw/langlaw_game.dart';

class HungryFly extends Fly{
  HungryFly(LangLawGame game, double x, double y) : super(game){
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.1, game.tileSize * 1.1);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('flies/hungry-fly-1.png'));
    flyingSprite.add(Sprite('flies/hungry-fly-2.png'));
    deadSprite = Sprite('flies/hungry-fly-dead.png');
  }


}