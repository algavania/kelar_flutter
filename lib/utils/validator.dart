import 'package:flutter/material.dart';
import 'package:kelar_flutter/l10n/l10n.dart';

class Validator {
  Validator({required this.context});

  final BuildContext context;

  String? emptyValidator(String? text) {
    if (text == null) return context.l10n.emptyValidatorMessage;
    if (text.trim().isEmpty) return context.l10n.emptyValidatorMessage;
    return null;
  }
}
