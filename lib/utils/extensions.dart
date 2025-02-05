import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:kelar_flutter/core/app_text_styles.dart';
import 'package:kelar_flutter/core/app_theme_data.dart';
import 'package:kelar_flutter/core/color_values.dart';
import 'package:kelar_flutter/core/enum.dart';
import 'package:kelar_flutter/core/styles.dart';
import 'package:kelar_flutter/l10n/l10n.dart';

// Extension on BuildContext for easy theme access
extension CustomThemeExtension on BuildContext {
  AppTextStyles get textTheme {
    final theme = AppTheme.of(this);
    assert(theme != null, 'No AppTheme found in context');
    return theme!.textTheme;
  }

  void showSnackBar({
    required String message,
    bool isSuccess = true,
    bool isTop = false,
  }) {
    final context = this;
    final backgroundColor =
        isSuccess ? ColorValues.success10 : ColorValues.danger10;
    final borderColor =
        isSuccess ? ColorValues.success20 : ColorValues.danger20;
    final color = isSuccess ? ColorValues.success50 : ColorValues.danger50;
    var flushbar = Flushbar();
    flushbar = Flushbar(
      flushbarPosition: isTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.symmetric(
        vertical: Styles.defaultPadding,
        horizontal: Styles.bigSpacing,
      ),
      padding: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(Styles.defaultBorder),
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      messageText: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Styles.smallerBorder),
              color: color,
              border: Border.all(color: borderColor),
            ),
            child: const Center(
              child: Icon(
                IconsaxPlusLinear.info_circle,
                color: ColorValues.white,
                size: 16,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Styles.defaultPadding),
              child:
                  Text(message, style: Theme.of(context).textTheme.bodySmall),
            ),
          ),
          GestureDetector(
            onTap: () => flushbar.dismiss(),
            child: const Icon(
              IconsaxPlusLinear.close_circle,
              size: 16,
              color: ColorValues.text50,
            ),
          ),
        ],
      ),
    )..show(context);
  }
}

/// Extension on [DateTime] to format it to a string with a specified locale.
extension FormattedDateTime on DateTime {
  /// Returns a formatted string representation of the [DateTime] object.
  ///
  /// The format of the string is "d MMMM y - HH:mm" by default, but can be
  /// customized by specifying a different [locale].
  String toFormattedString({String locale = 'id_ID'}) {
    final dateFormat = DateFormat('d MMMM y - HH:mm', locale);
    return dateFormat.format(this);
  }

  String toFormattedHour() {
    return DateFormat('HH:mm').format(this);
  }

  String toFormattedFullDate({String locale = 'id_ID'}) {
    return DateFormat('EEEE, d MMMM y', locale).format(this);
  }

  String toFormattedDate() {
    return DateFormat('d MMMM y').format(this);
  }

  String toFormattedShortDate() {
    return DateFormat('dd/MM/y').format(this);
  }

  String toFormattedDateWithHour() {
    return DateFormat('dd/MM/y HH:mm').format(this);
  }

  String toFormattedLongDateWithHour({String locale = 'id_ID'}) {
    return DateFormat('dd MMMM y HH:mm', locale).format(this);
  }

  String toYearMonthString() {
    return DateFormat('yyyyMM').format(this);
  }
}

extension UrgencyLevelExtension on UrgencyLevel {
  String getMessage(BuildContext context) {
    switch (this) {
      case UrgencyLevel.high:
        return context.l10n.high;
      case UrgencyLevel.medium:
        return context.l10n.medium;
      case UrgencyLevel.low:
        return context.l10n.low;
    }
  }
}

extension UrgencyExtension on num {
  UrgencyLevel getUrgencyLevel() {
    if (toInt() == UrgencyLevel.low.value) {
      return UrgencyLevel.low;
    } else if (toInt() == UrgencyLevel.medium.value) {
      return UrgencyLevel.medium;
    } else {
      return UrgencyLevel.high;
    }
  }
}

extension RoleExtension on RoleEnum {
  String getMessage(BuildContext context) {
    switch (this) {
      case RoleEnum.employee:
        return context.l10n.employee;
      case RoleEnum.manager:
        return context.l10n.manager;
    }
  }

  String getDescription(BuildContext context) {
    switch (this) {
      case RoleEnum.employee:
        return context.l10n.employeeDescription;
      case RoleEnum.manager:
        return context.l10n.managerDescription;
    }
  }
}

extension RoleString on String {
  RoleEnum getRole() {
    return RoleEnum.values.firstWhere((e) => e.name == this);
  }
}
