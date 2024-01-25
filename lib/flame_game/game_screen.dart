import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:infinite_base/bases/base_controller.dart';

import '../bases/base_page.dart';
import 'endless_runner.dart';

class GameScreen extends BasePage {
  const GameScreen(bundle, {super.key}) : super(bundle: bundle);

  @override
  State<GameScreen> createState() => GameScreenState();
}

class GameScreenState extends BasePageState<GameScreen> {

  @override
  Widget buildViews(BuildContext context) {
    return Scaffold(
      body: GameWidget<EndlessRunner>(
        game: EndlessRunner(),
      ),
    );
  }

  @override
  BaseController? initController() {
    return null;
  }


}
