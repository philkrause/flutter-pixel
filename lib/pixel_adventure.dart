import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:pixel_adventure/levels/level.dart'; 
import 'package:pixel_adventure/actors/player.dart';

class PixelAdventure extends FlameGame with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late CameraComponent cam;
  Player player = Player(character: 'Ninja Frog');
  late JoystickComponent joystick;
  bool showJoystick = true;

  @override
  FutureOr<void> onLoad() async {
    //load all images into cache
    await images.loadAllImages();

      final world = Level(
        levelName:'Level-02',
        player: player
      );
  
    //cam
    cam = CameraComponent.withFixedResolution(world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
   
    addAll([cam, world]);
    if (showJoystick){
      addJoystick();
    }
    return super.onLoad();
  }

  @override
  void update(double dt){
    if( showJoystick){
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoystick(){
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(images.fromCache('HUD/Knob.png'))
      ),
      background: SpriteComponent(
        sprite: Sprite(images.fromCache('HUD/Joystick.png'))
      ),
        margin: const EdgeInsets.only(left: 21, bottom: 32),
    );

    add(joystick);
  }

  void updateJoystick() {
    switch(joystick.direction){
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downLeft:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }



} 