import 'package:flutter/material.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/static/ui_const.dart';
import 'package:prayer_times/core/utility/utility.dart';

class CustomTextInputField extends StatelessWidget {
  const CustomTextInputField({
    super.key,
    required this.theme,
    this.title,
    required this.controller,
    required this.hintText,
    this.onChanged,
  });
  final ThemeData theme;
  final String? title;
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null && title!.isNotEmpty) ...[
          Text(
            title!,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: fourteenPx,
              fontWeight: FontWeight.w500,
            ),
          ),
          gapH10,
        ],
        TextField(
          controller: controller,
          onChanged: onChanged,
          onTapUpOutside: (_) => FocusScope.of(context).unfocus(),
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: fourteenPx,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: context.color.blackColor50,
            hintStyle: theme.textTheme.bodyMedium!.copyWith(
              fontSize: fourteenPx,
              fontWeight: FontWeight.w400,
            ),
            border: inputBorder(context),
            enabledBorder: inputBorder(context),
            focusedBorder: inputBorder(context),
          ),
        ),
      ],
    );
  }
}

OutlineInputBorder inputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: radius8,
    borderSide: BorderSide(
      color: context.color.blackColor300,
    ),
  );
}
