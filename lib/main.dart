import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kelar_flutter/core/app_text_styles.dart';
import 'package:kelar_flutter/core/app_theme_data.dart';
import 'package:kelar_flutter/core/color_values.dart';
import 'package:kelar_flutter/injector/injector.dart';
import 'package:kelar_flutter/l10n/l10n.dart';
import 'package:kelar_flutter/routes/router.dart';
import 'package:kelar_flutter/utils/shared_preferences_util.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

final appRouter = AppRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Injector.init();
  await SharedPreferencesUtil.init();
  await Injector.instance.allReady();
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
          child: GlobalLoaderOverlay(
            overlayColor: Colors.black.withOpacity(0.2),
            useDefaultLoading: false,
            overlayWidgetBuilder: (_) =>
                const SpinKitChasingDots(
                  color: ColorValues.primary50,
                  size: 40,
                ),
            child: MaterialApp.router(
              theme: appThemeData(context),
              routerDelegate: appRouter.delegate(),
              routeInformationParser: appRouter.defaultRouteParser(),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
            ),
          ),
        );
      },
    );
  }
}
