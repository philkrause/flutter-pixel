import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerState {idle, running}

class Player extends SpriteAnimationGroupComponent with HasGameRef<PixelAdventure> {
  
  String character;

  Player({required this.character});
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
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
}