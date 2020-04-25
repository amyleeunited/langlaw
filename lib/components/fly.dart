import 'dart:ui';
import 'package:langlaw/components/callout.dart';
import 'package:langlaw/langlaw_game.dart';
import 'package:flame/sprite.dart';
import 'package:langlaw/view.dart';
import 'package:flame/flame.dart';

class Fly {
  final LangLawGame game;
  Rect flyRect;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  Offset targetLocation;
  CallOut callOut;

  double get speed => game.tileSize * 3;

  Fly(this.game) {
    setTargetLocation();
    callOut = CallOut(this);
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() *
        (game.screenSize.width - (game.tileSize * 1.35));
    double y = (game.rnd.nextDouble() *
        (game.screenSize.height - (game.tileSize * 2.85))) + (game.tileSize * 1.5);
    targetLocation = Offset(x, y);
  }

  void render(Canvas c) {
    // c.drawRect(flyRect.inflate(flyRect.width / 2), Paint()..color = Color(0x77ffffff));
    
    if (isDead) {
      deadSprite.renderRect(c, flyRect.inflate(flyRect.width / 2));
    } else {
      if (game.activeView == View.playing) {
        callOut.render(c);
      }
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, flyRect.inflate(flyRect.width / 2));
    }
    // c.drawRect(flyRect, Paint()..color = Color(0x88000000));
  }

  void update(double t) {
    //make the fly fall
    if (isDead) {
      flyRect = flyRect.translate(0, 12 * game.tileSize * t);
      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    } else {
      //callout for counting down
      callOut.update(t);
      //flap the wings
      flyingSpriteIndex += 30 * t;
      while (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
      //make the fly move
      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget =
            Offset.fromDirection(toTarget.direction, stepDistance);
        flyRect = flyRect.shift(stepToTarget);
      } else {
        flyRect = flyRect.shift(toTarget);
        setTargetLocation();
      }
    }
  }

  void onTapDown() {
    if (!isDead) {
      if (game.soundButton.isEnabled) {
      Flame.audio.play('sfx/ouch' + (game.rnd.nextInt(11) + 1).toString() +'.mp3');
      }

      isDead = true;

      if (game.activeView == View.playing) {
        game.score += 1;

        if (game.score > (game.storage.getInt('highScore') ?? 0)) {
          game.storage.setInt('highScore', game.score);
          game.highScoreDisplay.updateHighScore();
        }
      }
    }
  }
}
