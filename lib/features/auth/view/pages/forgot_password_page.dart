import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:kelar_flutter/core/styles.dart';
import 'package:kelar_flutter/l10n/l10n.dart';
import 'package:kelar_flutter/widgets/custom_button.dart';
import 'package:kelar_flutter/widgets/custom_text_field.dart';
import 'package:unicons/unicons.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.forgotPassword),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(Styles.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: Styles.defaultSpacing,
                  ),
                  Text(context.l10n.forgotPasswordDescription),
                  const SizedBox(
                    height: Styles.defaultSpacing,
                  ),
                  CustomTextField(
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                    label: context.l10n.yourEmail,
                    hint: context.l10n.enterEmail,
                    icon: UniconsLine.envelope,
                  ),
                  const SizedBox(
                    height: Styles.bigSpacing,
                  ),
                  CustomButton(
                    text: context.l10n.submit,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
