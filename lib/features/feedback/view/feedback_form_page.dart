import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:kelar_flutter/core/color_values.dart';
import 'package:kelar_flutter/core/enum.dart';
import 'package:kelar_flutter/core/styles.dart';
import 'package:kelar_flutter/l10n/l10n.dart';
import 'package:kelar_flutter/utils/extensions.dart';
import 'package:kelar_flutter/utils/logger.dart';
import 'package:kelar_flutter/widgets/custom_button.dart';
import 'package:kelar_flutter/widgets/custom_gesture_unfocus.dart';
import 'package:kelar_flutter/widgets/custom_text_field.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

@RoutePage()
class FeedbackFormPage extends StatefulWidget {
  const FeedbackFormPage({super.key});

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _feedbackController = TextEditingController();
  final _urgencyList = [
    UrgencyLevel.low,
    UrgencyLevel.medium,
    UrgencyLevel.high,
  ];
  var _selectedUrgency = UrgencyLevel.low.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.addFeedback),
      ),
      body: CustomGestureUnfocus(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Styles.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUrgencyField(),
                const SizedBox(
                  height: Styles.bigSpacing,
                ),
                _buildFeedbackField(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(Styles.defaultPadding),
        child: _buildSubmitButton(),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return CustomButton(
      text: context.l10n.submit,
      onPressed: () {},
    );
  }

  Widget _buildUrgencyField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: context.l10n.urgency,
            style: Theme.of(context).textTheme.displaySmall,
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(color: ColorValues.danger50),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SfSlider(
          activeColor: ColorValues.primary50,
          labelFormatterCallback: (value, formatted) {
            return int.parse(formatted).getUrgencyLevel().getMessage(context);
          },
          min: _urgencyList.first.value,
          max: _urgencyList.last.value,
          value: _selectedUrgency,
          interval: 1,
          stepSize: 1,
          showLabels: true,
          onChanged: (dynamic value) {
            logger.d('value $value');
            setState(() {
              _selectedUrgency = (value as double).toInt();
            });
          },
        ),
      ],
    );
  }

  Widget _buildFeedbackField() {
    return CustomTextField(
      controller: _feedbackController,
      label: context.l10n.feedback,
      hint: context.l10n.feedbackHint,
      minLines: 5,
      maxLines: null,
    );
  }
}
