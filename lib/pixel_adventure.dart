import 'dart:async';

import 'package:flame/components.dart';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
 

  late CameraComponent cam;

  final world = Level();
  
  @override
  FutureOr<void> onLoad() async {
    //load all images into cache
    await images.loadAllImages();

    //cam
    cam = CameraComponent.withFixedResolution(world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
   
   
    addAll([cam, world]);

    return super.onLoad();
  }
}