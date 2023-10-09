import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerState {idle, running}
enum PlayerDirection {left,right,none}

class Player extends SpriteAnimationGroupComponent with HasGameRef<PixelAdventure>, KeyboardHandler {
  
  String character;

  //get position from SpirteAnimationGroupComponent and pass it to the player object
  Player({
    position, 
    this.character = 'Ninja Frog'
  }) : super(position: position);
  
  PlayerDirection playerDirection = PlayerDirection.none;

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  
  //fps   
  final double stepTime = 0.05;
  final double moveSpeed = 100;
  Vector2 velocity = Vector2(0, 0);
  bool facingRight = true;
  
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update (double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }
  
  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // TODO: implement onKeyEvent
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) || keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle', 11);
    runningAnimation = _spriteAnimation('Run', 12);

     animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
    };
  
    current = PlayerState.running;
  }  

  SpriteAnimation _spriteAnimation(String character_state, int frame_count){
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$character/$character_state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: frame_count, 
        stepTime: stepTime, 
        textureSize: Vector2(32,32),
      ),
    );
  }

  void _updatePlayerMovement(double dt){
    double dirX = 0.0;
    switch (playerDirection){
      case PlayerDirection.left: 
        if (facingRight) {
          flipHorizontallyAroundCenter();
          facingRight = false;
        }
        dirX -= moveSpeed;
        current = PlayerState.running;
      break;
      case PlayerDirection.right:
        current = PlayerState.running;
        dirX += moveSpeed;
        if (!facingRight) {
          facingRight = true;
        }
      break;
      case PlayerDirection.none:
        current = PlayerState.idle;
      break;
    default:
    }

    velocity = Vector2(dirX,0.0);
    position += velocity;
  }
} 