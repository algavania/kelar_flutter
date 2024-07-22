import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:kelar_flutter/core/color_values.dart';
import 'package:kelar_flutter/core/enum.dart';
import 'package:kelar_flutter/core/styles.dart';
import 'package:kelar_flutter/features/feedback/data/models/feedback_model.dart';
import 'package:kelar_flutter/features/feedback/view/bloc/feedback_bloc.dart';
import 'package:kelar_flutter/injector/injector.dart';
import 'package:kelar_flutter/l10n/l10n.dart';
import 'package:kelar_flutter/routes/router.dart';
import 'package:kelar_flutter/utils/extensions.dart';
import 'package:kelar_flutter/utils/shared_preferences_util.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _bloc = Injector.instance<FeedbackBloc>();
  var _isLoading = true;
  final _isManager = SharedPreferencesUtil.getUserData()?.role ==
      RoleEnum.manager.name;

  @override
  void initState() {
    _bloc.add(const FeedbackEvent.getFeedbacks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedbackBloc, FeedbackState>(
      bloc: _bloc,
      listener: (_, state) {
        state.maybeWhen(
          orElse: () {},
          added: () {
            _showSnackBar(context.l10n.addFeedbackSuccess);
          },
          edited: () {
            _showSnackBar(_isManager
                ? context.l10n.updateFeedbackManagerSuccess
                : context.l10n.updateFeedbackSuccess,);
          },
          deleted: () {
            _showSnackBar(context.l10n.deleteFeedbackSuccess);
          },
          error: (e) {
            _showSnackBar(e, isSuccess: false);
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.feedback),
        ),
        floatingActionButton: _buildFloatingButton(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Styles.defaultPadding),
            child: Column(
              children: [
                _buildBody(),
                const SizedBox(
                  height: Styles.bigSpacing,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message, {bool isSuccess = true}) {
    Future.delayed(Duration.zero, () {
      context.showSnackBar(message: message, isSuccess: isSuccess);
    });
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      onPressed: () {
        AutoRouter.of(context).push(FeedbackFormRoute());
      },
      child: const Icon(IconsaxPlusLinear.add),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      bloc: _bloc,
      builder: (context, state) {
        return StreamBuilder<List<FeedbackModel>>(
          stream: _bloc.feedbackStream,
          builder: (context, snapshot) {
            var list = <FeedbackModel>[];
            if (_isLoading) {
              list = List.generate(5, (_) => generateMockFeedbackModel());
            }

            if (snapshot.connectionState == ConnectionState.active) {
              _isLoading = false;
              list = snapshot.data ?? [];
            }

            return Skeletonizer(
              enabled: _isLoading,
              child: list.isEmpty
                  ? Center(
                      child: Text(context.l10n.emptyFeedback),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) => _buildListItem(list[i]),
                      separatorBuilder: (_, __) => const SizedBox(
                        height: Styles.defaultSpacing,
                      ),
                      itemCount: list.length,
                    ),
            );
          },
        );
      },
    );
  }

  Widget _buildListItem(FeedbackModel data) {
    final isReviewed = data.actionDescription != null;
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(FeedbackFormRoute(feedback: data));
      },
      child: Container(
        padding: const EdgeInsets.all(Styles.defaultPadding),
        decoration: BoxDecoration(
          color: ColorValues.white,
          borderRadius: BorderRadius.circular(Styles.defaultBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${context.l10n.urgency} ${data.urgencyLevel}',
                    style: context.textTheme.titleLarge,
                  ),
                ),
                const SizedBox(
                  width: Styles.defaultSpacing,
                ),
                Text(
                  data.createdAt.toFormattedDateWithHour(),
                  style: context.textTheme.bodySmall
                      .copyWith(color: ColorValues.grey50),
                ),
              ],
            ),
            const SizedBox(
              height: Styles.mediumSpacing,
            ),
            RichText(
              text: TextSpan(
                text: '${context.l10n.action}: ',
                style: context.textTheme.bodyMedium
                    .copyWith(color: ColorValues.grey50),
                children: [
                  TextSpan(
                    text: data.actionDescription == null
                        ? context.l10n.notReviewed
                        : context.l10n.reviewed,
                    style: context.textTheme.titleMedium.copyWith(
                      color: data.actionDescription == null
                          ? Colors.orange
                          : ColorValues.success50,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: Styles.defaultSpacing,
            ),
            Text(
              data.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if (isReviewed) const Divider(),
            if (isReviewed) Text(
              data.actionDescription ?? '-',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
