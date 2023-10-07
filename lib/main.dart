import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure.dart';
import 'package:flame/flame.dart';


void main() {
  //wait for flutter to intialize
  WidgetsFlutterBinding.ensureInitialized();
  
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  PixelAdventure game = PixelAdventure();
  runApp(GameWidget(game: kDebugMode ? PixelAdventure() : game));
}
