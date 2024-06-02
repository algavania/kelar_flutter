import 'package:flutter/material.dart';
import 'package:kelar_flutter/core/color_values.dart';
import 'package:kelar_flutter/core/styles.dart';
import 'package:kelar_flutter/utils/extensions.dart';
import 'package:kelar_flutter/utils/validator.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    super.key,
    this.hintText,
    this.prefixIcon,
    this.fillColor,
    this.borderWidth = 1,
    this.label,
    this.isRequired = true,
    this.validator,
    this.onChanged,
    this.maxCharacter,
    this.maxLines = 1,
    this.style,
    this.autofocus = false,
    this.expands = false,
    this.focusNode,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? label;
  final IconData? prefixIcon;
  final Color? fillColor;
  final double borderWidth;
  final bool isRequired;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final int? maxCharacter;
  final int? maxLines;
  final TextStyle? style;
  final bool autofocus;
  final bool expands;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        Styles.defaultBorder,
      ),
      borderSide: BorderSide(
        color: borderWidth == 0 ? Colors.transparent : ColorValues.grey10,
        width: borderWidth,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: context.textTheme.titleMedium,
          ),
        if (label != null)
          const SizedBox(
            height: Styles.defaultSpacing,
          ),
        TextFormField(
          expands: expands,
          focusNode: focusNode,
          autofocus: autofocus,
          maxLength: maxCharacter,
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          validator: isRequired
              ? (validator ?? Validator(context: context).emptyValidator)
              : validator,
          style: style ?? context.textTheme.bodyMedium,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            filled: fillColor != null,
            fillColor: fillColor,
            hintStyle: context.textTheme.labelSmallThin,
            border: border,
            enabledBorder: border,
            focusedErrorBorder: border,
            focusedBorder: border,
            errorBorder: border,
            disabledBorder: border,
            prefixIconConstraints: prefixIcon == null
                ? null
                : const BoxConstraints(
                    minWidth: 58,
                  ),
            prefixIcon: prefixIcon == null
                ? null
                : Icon(
                    prefixIcon,
                    size: 24,
                    color: ColorValues.grey90,
                  ),
            prefixIconColor: MaterialStateColor.resolveWith(
              (states) => states.contains(MaterialState.focused)
                  ? Theme.of(context).primaryColor
                  : ColorValues.grey50,
            ),
          ),
        ),
      ],
    );
  }
}
