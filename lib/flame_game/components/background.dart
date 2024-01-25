import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_base/configs/assets_config.dart';

class Background extends ParallaxComponent{


  @override
  Future<void> onLoad() async {
    final layers=[
      ParallaxImageData(AssetImageConfig.background),
    ];
    final baseVelocity = Vector2(30 , 0);
    final velocityMultiplierDelta = Vector2(2.0, 0.0);
    parallax= await game.loadParallax(
        layers,
        baseVelocity: baseVelocity,
        velocityMultiplierDelta: velocityMultiplierDelta,
        filterQuality:FilterQuality.none
    );
  }
}