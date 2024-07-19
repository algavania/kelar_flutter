import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kelar_flutter/core/color_values.dart';
import 'package:kelar_flutter/core/styles.dart';
import 'package:kelar_flutter/database/db_constants.dart';
import 'package:kelar_flutter/l10n/l10n.dart';
import 'package:kelar_flutter/routes/router.dart';
import 'package:kelar_flutter/utils/extensions.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (DbConstants.auth.currentUser == null) {
        AutoRouter.of(context).replace(const LoginRoute());
      } else {
        AutoRouter.of(context).replace(const DashboardRoute());
      }
    });
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/core/logo.png',
                width: 50.w,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: Styles.defaultSpacing),
              Text(
                'K3LAR',
                style: context.textTheme.titleLarger
                    .copyWith(color: ColorValues.primary50),
              ),
              Text(
                context.l10n.appTagline,
                style: context.textTheme.bodyMedium
                    .copyWith(color: ColorValues.primary50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
