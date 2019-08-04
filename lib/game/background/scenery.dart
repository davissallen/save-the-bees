import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components/composed_component.dart';
import 'package:save_the_bees/game/background/config.dart';
import 'package:save_the_bees/game/util/util.dart';


class SceneryManager extends PositionComponent with Resizable, ComposedComponent {
  Image spriteImage;
  SceneryManager(this.spriteImage) : super();

  // TODO: Don't think I need this one... but I may need update()
  void updateWithSpeed(double t, double speed) {
    final double cloudSpeed = BackgroundConfig.bgCloudSpeed / 1000 * t * speed;
    final int numClouds = this.components.length;

    if (numClouds > 0) {
      components.forEach((c) {
        Cloud cloud = c as Cloud;
        cloud.updateWithSpeed(t, cloudSpeed);
      });

      Cloud lastCloud = components.last;
      if (numClouds < BackgroundConfig.maxClouds &&
          (BackgroundDimensions.width / 2 - lastCloud.x) > lastCloud.cloudGap &&
          BackgroundConfig.cloudFrequency > rnd.nextDouble()) {
        addCloud();
      }
    } else {
      addCloud();
    }
  }

  addCloud() {
    Cloud cloud = Cloud(spriteImage);
    cloud.x = BackgroundDimensions.width / 2;
    cloud.y = (y / 2 - (CloudConfig.maxSkyLevel - CloudConfig.minSkyLevel)) +
        getRandomNum(CloudConfig.minSkyLevel, CloudConfig.maxSkyLevel);
    components.add(cloud);
  }

  void reset() {
    components.clear();
  }
}

class Cloud extends SpriteComponent with Resizable {
  final double cloudGap;
  bool toRemove = false;

  Cloud(Image spriteImage)
      : cloudGap =
            getRandomNum(CloudConfig.minCloudGap, CloudConfig.maxCloudGap),
        super.fromSprite(
            CloudConfig.width,
            CloudConfig.height,
            Sprite.fromImage(
              spriteImage,
              width: CloudConfig.width,
              height: CloudConfig.height,
              y: 2.0,
              x: 166.0,
            ));

  @override
  void update(double t) {}
  void updateWithSpeed(double t, double speed) {
    if (toRemove) return;
    x -= (speed.ceil() * 50 * t);

    if (!isVisible) {
      this.toRemove = true;
    }
  }

  bool destroy() {
    return toRemove;
  }

  bool get isVisible {
    return x + CloudConfig.width > 0;
  }

  @override
  resize(Size size) {
    y = (y / 2 - (CloudConfig.maxSkyLevel - CloudConfig.minSkyLevel)) +
        getRandomNum(CloudConfig.minSkyLevel, CloudConfig.maxSkyLevel);
  }
}
