import 'package:auto_route/auto_route.dart';
import 'package:example/UI/home_screen.dart';

part 'navigation.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
        ),
      ];
}
