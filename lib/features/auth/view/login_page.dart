import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kelar_flutter/core/color_values.dart';
import 'package:kelar_flutter/core/styles.dart';
import 'package:kelar_flutter/l10n/l10n.dart';
import 'package:kelar_flutter/routes/router.dart';
import 'package:kelar_flutter/widgets/custom_button.dart';
import 'package:kelar_flutter/widgets/custom_gesture_unfocus.dart';
import 'package:kelar_flutter/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:unicons/unicons.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomGestureUnfocus(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  margin: const EdgeInsets.all(Styles.defaultPadding),
                  child: Column(
                    children: [
                      SizedBox(height: 5.h),
                      SizedBox(height: 6.h),
                      Text(
                        context.l10n.loginText1,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 1.5.h),
                      Text(
                        context.l10n.loginText2,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: ColorValues.grey50),
                      ),
                      SizedBox(height: 5.h),
                      CustomTextField(
                        textInputType: TextInputType.emailAddress,
                        controller: _emailController,
                        label: context.l10n.yourEmail,
                        hint: context.l10n.enterEmail,
                        icon: UniconsLine.envelope,
                      ),
                      const SizedBox(height: Styles.defaultSpacing),
                      CustomTextField(
                        controller: _passwordController,
                        label: context.l10n.yourPassword,
                        hint: context.l10n.enterPassword,
                        icon: UniconsLine.key_skeleton,
                        isPassword: true,
                      ),
                      const SizedBox(height: Styles.defaultSpacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              AutoRouter.of(context)
                                  .push(const ForgotPasswordRoute());
                            },
                            child: Text(
                              context.l10n.forgotPasswordText,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Styles.bigSpacing),
                      CustomButton(
                        text: context.l10n.login,
                        onPressed: () {
                          AutoRouter.of(context)
                              .replace(const DashboardRoute());
                        },
                      ),
                      Expanded(child: Container()),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
