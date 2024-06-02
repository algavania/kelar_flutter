import 'package:flutter/material.dart';
import 'package:kelar_flutter/core/app_text_styles.dart';
import 'package:kelar_flutter/core/app_theme_data.dart';
import 'package:kelar_flutter/l10n/l10n.dart';
import 'package:kelar_flutter/routes/router.dart';
import 'package:sizer/sizer.dart';

final appRouter = AppRouter();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return AppTheme(
          textTheme: AppTextStyles.style(context),
          child: MaterialApp.router(
            theme: appThemeData(context),
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
