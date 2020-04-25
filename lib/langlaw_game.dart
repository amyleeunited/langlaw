import 'dart:ui';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:langlaw/components/display-high-score.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:langlaw/components/fly.dart';
import 'package:langlaw/components/backyard.dart';
import 'package:langlaw/components/house-fly.dart';
import 'package:langlaw/components/hungry-fly.dart';
import 'package:langlaw/components/drooler-fly.dart';
import 'package:langlaw/components/macho-fly.dart';
import 'package:langlaw/components/agile-fly.dart';
import 'package:langlaw/components/views/credits-view.dart';
import 'package:langlaw/components/views/help-view.dart';
import 'package:langlaw/components/views/lost-view.dart';
import 'package:langlaw/view.dart';
import 'package:langlaw/components/views/home-view.dart';
import 'package:langlaw/components/start-button.dart';
import 'package:langlaw/controller/spawner.dart';
import 'package:langlaw/components/help-button.dart';
import 'package:langlaw/components/credits-button.dart';
import 'package:langlaw/components/score-display.dart';
import 'package:langlaw/components/music-button.dart';
import 'package:langlaw/components/sound-button.dart';

class LangLawGame extends Game {
  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Random rnd;
  BackYard backyard;
  int score;

  View activeView = View.home;
  HomeView home;
  StartButton startButton;
  LostView lostView;
  FlySpawner spawner;
  HelpButton helpButton;
  CreditsButton creditsButton;
  HelpView helpView;
  CreditsView creditsView;
  ScoreDisplay scoreDisplay;
  HighScoreDisplay highScoreDisplay;
  final SharedPreferences storage;
  AudioPlayer homeBGM;
  AudioPlayer playingBGM;
  MusicButton musicButton;
  SoundButton soundButton;

  LangLawGame(this.storage) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    score = 0;
    flies = List<Fly>();
    rnd = Random();
    backyard = BackYard(this);
    home = HomeView(this);
    startButton = StartButton(this);
    lostView = LostView(this);
    spawner = FlySpawner(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    helpView = HelpView(this);
    creditsView = CreditsView(this);
    scoreDisplay = ScoreDisplay(this);
    highScoreDisplay = HighScoreDisplay(this);
    musicButton = MusicButton(this);
    soundButton = SoundButton(this);

    homeBGM = await Flame.audio.loop('bgm/home.mp3', volume: 0.25);
    homeBGM.pause();
    playingBGM = await Flame.audio.loop('bgm/playing.mp3', volume: 0.25);
    playingBGM.pause();

    playHomeBGM();
  }

  void playHomeBGM() {
    playingBGM.pause();
    playingBGM.seek(Duration.zero);
    homeBGM.resume();
  }

  void playPlayingBGM() {
    homeBGM.pause();
    homeBGM.seek(Duration.zero);
    playingBGM.resume();
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 1.35));
    double y = (rnd.nextDouble() * (screenSize.height - (tileSize * 2.85))) + (tileSize * 1.5);
    switch (rnd.nextInt(5)) {
      case 0:
        flies.add(AgileFly(this, x, y));
        break;
      case 1:
        flies.add(HouseFly(this, x, y));
        break;
      case 2:
        flies.add(HungryFly(this, x, y));
        break;
      case 3:
        flies.add(MachoFly(this, x, y));
        break;
      case 4:
        flies.add(DroolerFly(this, x, y));
        break;
    }
  }

  @override
  void render(Canvas canvas) {
    // Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    // Paint bgPaint = Paint();
    // bgPaint.color = Color(0xff576574);
    // canvas.drawRect(bgRect, bgPaint);

    backyard.render(canvas);

    highScoreDisplay.render(canvas);

    if (activeView == View.playing) scoreDisplay.render(canvas);

    flies.forEach((Fly fly) => fly.render(canvas));

    if (activeView == View.home) home.render(canvas);
    if (activeView == View.lost) lostView.render(canvas);

    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
      helpButton.render(canvas);
      creditsButton.render(canvas);
    }
    musicButton.render(canvas);
    soundButton.render(canvas);

    if (activeView == View.help) helpView.render(canvas);
    if (activeView == View.credits) creditsView.render(canvas);
  }

  @override
  void update(double t) {
    flies.forEach((Fly fly) => fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
    spawner.update(t);
    if (activeView == View.playing) {
      scoreDisplay.update(t);
    }
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;
    //start Button
    if (!isHandled && startButton.startRect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown(d);
        isHandled = true;
      }
    }
    //disable background music
    if (!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapDown(d);
      isHandled = true;
    }
    //disable sound effects
    if (!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapDown(d);
      isHandled = true;
    }
    //help Button
    if (!isHandled && helpButton.helpBtnRect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown(d);
        isHandled = true;
      }
    }
    //credits Button
    if (!isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown(d);
        isHandled = true;
      }
    }
    //credits and help dialog
    if (!isHandled) {
      if (activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }
    //hit a fly
    if (!isHandled) {
      bool didHitAFly = false;
      flies.forEach((Fly fly) {
        if (fly.flyRect.contains(d.globalPosition)) {
          fly.onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      });
      if (activeView == View.playing && !didHitAFly) {
        if (soundButton.isEnabled) {
          Flame.audio.play('sfx/haha' + (rnd.nextInt(5) + 1).toString() +'.mp3');
        }
        activeView = View.lost;
      }
    }
    

  }
}
