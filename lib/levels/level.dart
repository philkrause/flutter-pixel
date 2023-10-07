import 'dart:async';

import "package:flame/components.dart";

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/actors/player.dart';


class Level extends World {

  late TiledComponent level; 

  @override
  FutureOr<void> onLoad() async {

    level = await TiledComponent.load('Level-01.tmx',Vector2(16, 16));

    add(level);
    add(Player(character: 'Ninja Frog'));
    
    return super.onLoad();
  }
} 