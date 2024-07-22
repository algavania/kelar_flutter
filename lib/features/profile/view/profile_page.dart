import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:kelar_flutter/core/color_values.dart';
import 'package:kelar_flutter/core/styles.dart';
import 'package:kelar_flutter/features/auth/view/bloc/auth_bloc.dart';
import 'package:kelar_flutter/features/dashboard/view/bloc/dashboard_bloc.dart';
import 'package:kelar_flutter/features/feedback/view/bloc/feedback_bloc.dart';
import 'package:kelar_flutter/injector/injector.dart';
import 'package:kelar_flutter/l10n/l10n.dart';
import 'package:kelar_flutter/routes/router.dart';
import 'package:kelar_flutter/utils/extensions.dart';
import 'package:kelar_flutter/utils/shared_preferences_util.dart';
import 'package:kelar_flutter/widgets/custom_alert_dialog.dart';
import 'package:kelar_flutter/widgets/custom_button.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _role = SharedPreferencesUtil.getUserData()!.role.getRole();
  final _bloc = Injector.instance<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {
            context.loaderOverlay.hide();
          },
          loading: () {
            context.loaderOverlay.show();
          },
          loggedOut: () {
            context.loaderOverlay.hide();
            // Reset all bloc
            Injector.instance<DashboardBloc>()
                .add(const DashboardEvent.reset());
            Injector.instance<FeedbackBloc>().add(const FeedbackEvent.reset());
            AutoRouter.of(context).replace(const LoginRoute());
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.profile),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: _buildLogoutButton(),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: 100.w,
            child: Padding(
              padding: const EdgeInsets.all(Styles.defaultPadding),
              child: Column(
                children: [
                  _buildProfileWidget(),
                  const SizedBox(
                    height: Styles.bigSpacing,
                  ),
                  _buildDescriptionWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return CustomButton(
      text: context.l10n.logout,
      backgroundColor: ColorValues.danger50,
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (_) => CustomAlertDialog(
            title: context.l10n.confirmation,
            description: context.l10n.logoutAlert,
            proceedText: context.l10n.yes,
            cancelText: context.l10n.no,
            proceedAction: () {
              _bloc.add(const AuthEvent.logout());
            },
          ),
        );
      },
    );
  }

  Widget _buildDescriptionWidget() {
    return Container(
      padding: const EdgeInsets.all(Styles.defaultPadding),
      decoration: BoxDecoration(
        color: ColorValues.white,
        borderRadius: BorderRadius.circular(Styles.defaultBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.description,
            style: context.textTheme.titleMedium,
          ),
          Text(
            _role.getDescription(context),
            style: const TextStyle(color: ColorValues.grey50),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 48,
          backgroundColor: ColorValues.primary50,
          child: Icon(
            IconsaxPlusBold.profile,
            size: 64,
            color: ColorValues.white,
          ),
        ),
        const SizedBox(
          height: Styles.mediumSpacing,
        ),
        Text(
          SharedPreferencesUtil.getUserData()?.name ??
              _role.getMessage(context),
          style: context.textTheme.titleLarge,
        ),
        const SizedBox(
          height: Styles.smallSpacing,
        ),
        Text(
          _role.getMessage(context),
          style: const TextStyle(color: ColorValues.grey50),
        ),
      ],
    );
  }
}
