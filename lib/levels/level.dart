import 'dart:async';

import "package:flame/components.dart";
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';
import 'package:pixel_adventure/actors/player.dart';

class Level extends World {

  final String levelName;
  final Player player; 
  Level({required this.levelName, required this.player});
  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$levelName.tmx',Vector2(16, 16));
    
    add(level);
    
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if(spawnPointsLayer != null){
        for (final spawnPoint in spawnPointsLayer.objects) {
          
          switch (spawnPoint.class_){
              case 'Player':
                final player = Player(
                  character: 'Ninja Frog',
                  position: Vector2(spawnPoint.x, spawnPoint.y),
                );
                player.position = Vector2(spawnPoint.x, spawnPoint.y);
                add(player);
              break;

          default:
          }
        }  
    }  
    return super.onLoad();
  }
} 