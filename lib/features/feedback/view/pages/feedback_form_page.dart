import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:kelar_flutter/core/color_values.dart';
import 'package:kelar_flutter/core/enum.dart';
import 'package:kelar_flutter/core/styles.dart';
import 'package:kelar_flutter/database/db_constants.dart';
import 'package:kelar_flutter/features/feedback/data/models/feedback_model.dart';
import 'package:kelar_flutter/features/feedback/view/bloc/feedback_bloc.dart';
import 'package:kelar_flutter/injector/injector.dart';
import 'package:kelar_flutter/l10n/l10n.dart';
import 'package:kelar_flutter/utils/extensions.dart';
import 'package:kelar_flutter/utils/logger.dart';
import 'package:kelar_flutter/utils/shared_preferences_util.dart';
import 'package:kelar_flutter/utils/validator.dart';
import 'package:kelar_flutter/widgets/custom_alert_dialog.dart';
import 'package:kelar_flutter/widgets/custom_button.dart';
import 'package:kelar_flutter/widgets/custom_gesture_unfocus.dart';
import 'package:kelar_flutter/widgets/custom_text_field.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

@RoutePage()
class FeedbackFormPage extends StatefulWidget {
  const FeedbackFormPage({super.key, this.feedback});

  final FeedbackModel? feedback;

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _feedbackController = TextEditingController();
  final _actionController = TextEditingController();
  final _urgencyList = [
    UrgencyLevel.low,
    UrgencyLevel.medium,
    UrgencyLevel.high,
  ];
  final _formKey = GlobalKey<FormState>();
  var _selectedUrgency = UrgencyLevel.low.value;
  final _bloc = Injector.instance<FeedbackBloc>();
  bool _canDelete = false;
  bool _canEditFields = false;
  final _isManager =
      SharedPreferencesUtil.getUserData()?.role == RoleEnum.manager.name;

  @override
  void initState() {
    if (widget.feedback != null) {
      _selectedUrgency = widget.feedback!.urgencyLevel;
      _feedbackController.text = widget.feedback!.content;
      _actionController.text = widget.feedback!.actionDescription ?? '';
      _canDelete = true;

      final uid = DbConstants.auth.currentUser!.uid;

      _canEditFields = widget.feedback?.createdBy == uid &&
          widget.feedback?.actionDescription == null;
    } else {
      _canEditFields = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedbackBloc, FeedbackState>(
      bloc: _bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loading: () {
            context.loaderOverlay.show();
          },
          edited: () {
            _popRoute();
          },
          added: () {
            _popRoute();
          },
          deleted: () {
            _popRoute();
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _isManager
                ? context.l10n.reviewFeedback
                : (widget.feedback != null
                    ? context.l10n.editFeedback
                    : context.l10n.addFeedback),
          ),
          actions: [
            if (_canDelete && !_isManager)
              IconButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (_) => CustomAlertDialog(
                      title: context.l10n.confirmation,
                      description: context.l10n.deleteFeedbackAlert,
                      proceedText: context.l10n.yes,
                      cancelText: context.l10n.no,
                      proceedAction: () {
                        _bloc.add(
                          FeedbackEvent.deleteFeedback(
                            widget.feedback!.id!,
                          ),
                        );
                      },
                    ),
                  );
                },
                icon: const Icon(
                  IconsaxPlusBold.trash,
                  color: ColorValues.danger50,
                ),
              ),
          ],
        ),
        body: CustomGestureUnfocus(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Styles.defaultPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUrgencyField(),
                    const SizedBox(
                      height: Styles.bigSpacing,
                    ),
                    _buildFeedbackField(),
                    const SizedBox(
                      height: Styles.bigSpacing,
                    ),
                    if (_isManager ||
                        widget.feedback?.actionDescription != null)
                      _buildManagerFields(),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: _buildSubmitButton(),
        ),
      ),
    );
  }

  void _popRoute() {
    context.loaderOverlay.hide();
    AutoRouter.of(context).maybePop();
  }

  Widget _buildManagerFields() {
    return CustomTextField(
      enabled: _isManager,
      controller: _actionController,
      label: context.l10n.action,
      hint: context.l10n.actionHint,
      minLines: 5,
      maxLines: null,
      isRequired: _isManager,
      validator:
          !_isManager ? null : Validator(context: context).emptyValidator,
    );
  }

  Widget _buildSubmitButton() {
    return CustomButton(
      text: context.l10n.submit,
      onPressed: widget.feedback != null &&
              widget.feedback?.actionDescription != null &&
              !_isManager
          ? null
          : () {
              if (_formKey.currentState?.validate() ?? true) {
                final content = _feedbackController.text.trim();
                final action = _actionController.text.trim();
                final uid = DbConstants.auth.currentUser!.uid;
                final now = DateTime.now();
                if (widget.feedback != null) {
                  final data = widget.feedback!.copyWith(
                    updatedAt: now,
                    urgencyLevel: _selectedUrgency,
                    content: content,
                    actionDescription: action,
                  );
                  _bloc.add(FeedbackEvent.updateFeedback(data));
                } else {
                  final data = FeedbackModel(
                    createdAt: now,
                    updatedAt: now,
                    content: content,
                    createdBy: uid,
                    urgencyLevel: _selectedUrgency,
                  );
                  _bloc.add(FeedbackEvent.addFeedback(data));
                }
              }
            },
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
          onChanged: !_canEditFields
              ? null
              : (dynamic value) {
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
      enabled: _canEditFields,
      controller: _feedbackController,
      label: context.l10n.feedback,
      hint: context.l10n.feedbackHint,
      minLines: 5,
      maxLines: null,
      validator: Validator(context: context).emptyValidator,
    );
  }
}
