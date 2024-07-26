import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kelar_flutter/features/feedback/data/models/feedback_model.dart';

import 'package:kelar_flutter/features/pages.dart';

part 'router.gr.dart';

// generate with dart run build_runner build
@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      page: SplashRoute.page,
      path: '/splash',
      initial: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: LoginRoute.page,
      path: '/login',
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: ForgotPasswordRoute.page,
      path: '/forgot-password',
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: DashboardRoute.page,
      path: '/dashboard',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      children: [
        CustomRoute(
          page: HomeRoute.page,
          path: 'home',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: FeedbackRoute.page,
          path: 'feedback',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: StatisticRoute.page,
          path: 'statistic',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: ProfileRoute.page,
          path: 'profile',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
      ],
    ),
    CustomRoute(
      page: FeedbackFormRoute.page,
      path: '/feedback-form',
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
  ];
}
