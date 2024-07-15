import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:kelar_flutter/core/color_values.dart';
import 'package:kelar_flutter/core/styles.dart';
import 'package:kelar_flutter/features/feedback/data/models/feedback_model.dart';
import 'package:kelar_flutter/l10n/l10n.dart';
import 'package:kelar_flutter/routes/router.dart';
import 'package:kelar_flutter/utils/extensions.dart';

@RoutePage()
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    final list = List.generate(5, (_) => generateMockFeedbackModel());
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.feedback),
      ),
      floatingActionButton: _buildFloatingButton(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: Column(
            children: [
              _buildBody(list),
              const SizedBox(
                height: Styles.bigSpacing,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      onPressed: () {
        AutoRouter.of(context).push(const FeedbackFormRoute());
      },
      child: const Icon(IconsaxPlusLinear.add),
    );
  }

  Widget _buildBody(List<FeedbackModel> list) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) => _buildListItem(list[i]),
      separatorBuilder: (_, __) => const SizedBox(
        height: Styles.defaultSpacing,
      ),
      itemCount: list.length,
    );
  }

  Widget _buildListItem(FeedbackModel data) {
    return Container(
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
                  data.title,
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
                TextSpan(text: data.action ?? '-'),
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
        ],
      ),
    );
  }
}
