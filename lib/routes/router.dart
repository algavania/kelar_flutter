import 'package:auto_route/auto_route.dart';

import 'package:kelar_flutter/features/pages.dart';

part 'router.gr.dart';

// generate with dart run build_runner build
@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      page: LoginRoute.page,
      path: '/login',
      initial: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
  ];
}
