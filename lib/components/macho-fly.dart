import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:langlaw/components/fly.dart';
import 'package:langlaw/langlaw_game.dart';

class MachoFly extends Fly{

  double get speed => game.tileSize * 2.5;
  MachoFly(LangLawGame game, double x, double y) : super(game){
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.35, game.tileSize * 1.35);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('flies/macho-fly-1.png'));
    flyingSprite.add(Sprite('flies/macho-fly-2.png'));
    deadSprite = Sprite('flies/macho-fly-dead.png');
  }

}