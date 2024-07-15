import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:kelar_flutter/l10n/l10n.dart';
import 'package:kelar_flutter/routes/router.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        FeedbackRoute(),
        StatisticRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          destinations: [
            NavigationDestination(
              icon: const Icon(IconsaxPlusBold.home),
              label: context.l10n.home,
            ),
            NavigationDestination(
              icon: const Icon(IconsaxPlusBold.messages),
              label: context.l10n.feedback,
            ),
            NavigationDestination(
              icon: const Icon(IconsaxPlusBold.chart),
              label: context.l10n.statistic,
            ),
            NavigationDestination(
              icon: const Icon(IconsaxPlusBold.user),
              label: context.l10n.profile,
            ),
          ],
        );
      },
    );
  }
}
