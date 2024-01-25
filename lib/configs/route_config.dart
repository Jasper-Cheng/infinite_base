import 'package:go_router/go_router.dart';
import 'package:infinite_base/flame_game/game_screen.dart';
import 'package:infinite_base/pages/error_page.dart';
import 'package:infinite_base/pages/login_page.dart';
import 'package:infinite_base/pages/main_page.dart';
import 'package:infinite_base/pages/splash_page.dart';
import 'package:infinite_base/bases/bundle.dart';

import '../listener/my_navigator_observer.dart';
import 'key_config.dart';

class RouteConfig{
  static final GoRouter router = GoRouter(
    initialLocation: RoutePath.game_screen,
    errorBuilder: (context, state){
      Bundle bundle=Bundle();
      bundle.putObject(KeyConfig.map_error_key, state.error);
      return ErrorPage(bundle);
    },
    observers: [
      MyNavigatorObserver(),
    ],
    routes: <RouteBase>[
      //splash--启动页
      GoRoute(
        path: RoutePath.splash,
        builder: (context, state) => const SplashPage(),
      ),
      //login-登录页
      GoRoute(
        path: RoutePath.login,
        builder: (context, state) => const LoginPage(),
      ),
      //main-首页
      GoRoute(
        path: RoutePath.main,
        builder: (context, state) => MainPage(state.extra),
      ),
      //game_screen-游戏页面
      GoRoute(
        path: RoutePath.game_screen,
        builder: (context, state) => GameScreen(state.extra),
      )
    ],
  );

}
class RoutePath{
  static const String splash="/splash";
  static const String login="/login";
  static const String main="/main";
  static const String game_screen="/game_screen";
}
