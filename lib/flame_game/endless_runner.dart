import 'package:flame/game.dart';
import 'components/background.dart';
import 'endless_world.dart';

class EndlessRunner extends FlameGame<EndlessWorld> with HasCollisionDetection{

  EndlessRunner() : super(
    world: EndlessWorld(),
  );

  @override
  Future<void> onLoad() async {
    camera.backdrop.add(Background());
  }

}
