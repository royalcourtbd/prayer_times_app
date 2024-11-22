import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_color.dart';

class PrayerTimeThemeColor extends ThemeExtension<PrayerTimeThemeColor> {
  // Existing properties
  final Color scaffoldBachgroundColor;
  final Color primaryColor;
  final Color whiteColor;
  final Color backgroundColor;
  final Color modalBgColor;
  final Color tapGroupBgColor;
  final Color tabActiveColor;
  final Color borderColor;
  final Color titleColor;
  final Color subTitleColor;
  final Color bodyColor;
  final Color placeHolderColor;
  final Color linkColor;
  final Color buttonColor;
  final Color buttonBgColor;
  final Color captionColor;
  final Color disableColor;
  final Color successColor;
  final Color warningColor;
  final Color errorColor;

  // Primary Color Properties
  final Color primaryColor900;
  final Color primaryColor800;
  final Color primaryColor700;
  final Color primaryColor600;
  final Color primaryColor500;
  final Color primaryColor400;
  final Color primaryColor300;
  final Color primaryColor200;
  final Color primaryColor100;
  final Color primaryColor25;

  // Black Color Properties
  final Color blackColor900;
  final Color blackColor800;
  final Color blackColor700;
  final Color blackColor600;
  final Color blackColor500;
  final Color blackColor400;
  final Color blackColor300;
  final Color blackColor200;
  final Color blackColor100;
  final Color blackColor50;
  final Color blackColor25;

  // Error Color Properties
  final Color errorColor900;
  final Color errorColor800;
  final Color errorColor700;
  final Color errorColor600;
  final Color errorColor500;
  final Color errorColor400;
  final Color errorColor300;
  final Color errorColor200;
  final Color errorColor100;
  final Color errorColor50;
  final Color errorColor25;

  const PrayerTimeThemeColor({
    // Existing required properties
    required this.scaffoldBachgroundColor,
    required this.primaryColor,
    required this.whiteColor,
    required this.backgroundColor,
    required this.modalBgColor,
    required this.tapGroupBgColor,
    required this.tabActiveColor,
    required this.borderColor,
    required this.titleColor,
    required this.subTitleColor,
    required this.bodyColor,
    required this.placeHolderColor,
    required this.linkColor,
    required this.buttonColor,
    required this.buttonBgColor,
    required this.captionColor,
    required this.disableColor,
    required this.successColor,
    required this.warningColor,
    required this.errorColor,

    // Primary Color required properties
    required this.primaryColor900,
    required this.primaryColor800,
    required this.primaryColor700,
    required this.primaryColor600,
    required this.primaryColor500,
    required this.primaryColor400,
    required this.primaryColor300,
    required this.primaryColor200,
    required this.primaryColor100,
    required this.primaryColor25,

    // Black Color required properties
    required this.blackColor900,
    required this.blackColor800,
    required this.blackColor700,
    required this.blackColor600,
    required this.blackColor500,
    required this.blackColor400,
    required this.blackColor300,
    required this.blackColor200,
    required this.blackColor100,
    required this.blackColor50,
    required this.blackColor25,

    // Error Color required properties
    required this.errorColor900,
    required this.errorColor800,
    required this.errorColor700,
    required this.errorColor600,
    required this.errorColor500,
    required this.errorColor400,
    required this.errorColor300,
    required this.errorColor200,
    required this.errorColor100,
    required this.errorColor50,
    required this.errorColor25,
  });

  @override
  PrayerTimeThemeColor copyWith({
    // Existing properties
    Color? scaffoldBachgroundColor,
    Color? primaryColor,
    Color? whiteColor,
    Color? backgroundColor,
    Color? modalBgColor,
    Color? tapGroupBgColor,
    Color? tabActiveColor,
    Color? borderColor,
    Color? titleColor,
    Color? subTitleColor,
    Color? bodyColor,
    Color? placeHolderColor,
    Color? linkColor,
    Color? buttonColor,
    Color? buttonBgColor,
    Color? captionColor,
    Color? disableColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,

    // Primary Color properties
    Color? primaryColor900,
    Color? primaryColor800,
    Color? primaryColor700,
    Color? primaryColor600,
    Color? primaryColor500,
    Color? primaryColor400,
    Color? primaryColor300,
    Color? primaryColor200,
    Color? primaryColor100,
    Color? primaryColor25,

    // Black Color properties
    Color? blackColor900,
    Color? blackColor800,
    Color? blackColor700,
    Color? blackColor600,
    Color? blackColor500,
    Color? blackColor400,
    Color? blackColor300,
    Color? blackColor200,
    Color? blackColor100,
    Color? blackColor50,
    Color? blackColor25,

    // Error Color properties
    Color? errorColor900,
    Color? errorColor800,
    Color? errorColor700,
    Color? errorColor600,
    Color? errorColor500,
    Color? errorColor400,
    Color? errorColor300,
    Color? errorColor200,
    Color? errorColor100,
    Color? errorColor50,
    Color? errorColor25,
  }) {
    return PrayerTimeThemeColor(
      // Existing properties
      scaffoldBachgroundColor:
          scaffoldBachgroundColor ?? this.scaffoldBachgroundColor,
      primaryColor: primaryColor ?? this.primaryColor,
      whiteColor: whiteColor ?? this.whiteColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      modalBgColor: modalBgColor ?? this.modalBgColor,
      tapGroupBgColor: tapGroupBgColor ?? this.tapGroupBgColor,
      tabActiveColor: tabActiveColor ?? this.tabActiveColor,
      borderColor: borderColor ?? this.borderColor,
      titleColor: titleColor ?? this.titleColor,
      subTitleColor: subTitleColor ?? this.subTitleColor,
      bodyColor: bodyColor ?? this.bodyColor,
      placeHolderColor: placeHolderColor ?? this.placeHolderColor,
      linkColor: linkColor ?? this.linkColor,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonBgColor: buttonBgColor ?? this.buttonBgColor,
      captionColor: captionColor ?? this.captionColor,
      disableColor: disableColor ?? this.disableColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,

      // Primary Color properties
      primaryColor900: primaryColor900 ?? this.primaryColor900,
      primaryColor800: primaryColor800 ?? this.primaryColor800,
      primaryColor700: primaryColor700 ?? this.primaryColor700,
      primaryColor600: primaryColor600 ?? this.primaryColor600,
      primaryColor500: primaryColor500 ?? this.primaryColor500,
      primaryColor400: primaryColor400 ?? this.primaryColor400,
      primaryColor300: primaryColor300 ?? this.primaryColor300,
      primaryColor200: primaryColor200 ?? this.primaryColor200,
      primaryColor100: primaryColor100 ?? this.primaryColor100,
      primaryColor25: primaryColor25 ?? this.primaryColor25,

      // Black Color properties
      blackColor900: blackColor900 ?? this.blackColor900,
      blackColor800: blackColor800 ?? this.blackColor800,
      blackColor700: blackColor700 ?? this.blackColor700,
      blackColor600: blackColor600 ?? this.blackColor600,
      blackColor500: blackColor500 ?? this.blackColor500,
      blackColor400: blackColor400 ?? this.blackColor400,
      blackColor300: blackColor300 ?? this.blackColor300,
      blackColor200: blackColor200 ?? this.blackColor200,
      blackColor100: blackColor100 ?? this.blackColor100,
      blackColor50: blackColor50 ?? this.blackColor50,
      blackColor25: blackColor25 ?? this.blackColor25,

      // Error Color properties
      errorColor900: errorColor900 ?? this.errorColor900,
      errorColor800: errorColor800 ?? this.errorColor800,
      errorColor700: errorColor700 ?? this.errorColor700,
      errorColor600: errorColor600 ?? this.errorColor600,
      errorColor500: errorColor500 ?? this.errorColor500,
      errorColor400: errorColor400 ?? this.errorColor400,
      errorColor300: errorColor300 ?? this.errorColor300,
      errorColor200: errorColor200 ?? this.errorColor200,
      errorColor100: errorColor100 ?? this.errorColor100,
      errorColor50: errorColor50 ?? this.errorColor50,
      errorColor25: errorColor25 ?? this.errorColor25,
    );
  }

  @override
  ThemeExtension<PrayerTimeThemeColor> lerp(
      ThemeExtension<PrayerTimeThemeColor>? other, double t) {
    if (other is! PrayerTimeThemeColor) {
      return this;
    }
    return PrayerTimeThemeColor(
      // Existing properties
      scaffoldBachgroundColor: Color.lerp(
          scaffoldBachgroundColor, other.scaffoldBachgroundColor, t)!,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      modalBgColor: Color.lerp(modalBgColor, other.modalBgColor, t)!,
      tapGroupBgColor: Color.lerp(tapGroupBgColor, other.tapGroupBgColor, t)!,
      tabActiveColor: Color.lerp(tabActiveColor, other.tabActiveColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      titleColor: Color.lerp(titleColor, other.titleColor, t)!,
      subTitleColor: Color.lerp(subTitleColor, other.subTitleColor, t)!,
      bodyColor: Color.lerp(bodyColor, other.bodyColor, t)!,
      placeHolderColor:
          Color.lerp(placeHolderColor, other.placeHolderColor, t)!,
      linkColor: Color.lerp(linkColor, other.linkColor, t)!,
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t)!,
      buttonBgColor: Color.lerp(buttonBgColor, other.buttonBgColor, t)!,
      captionColor: Color.lerp(captionColor, other.captionColor, t)!,
      disableColor: Color.lerp(disableColor, other.disableColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,

      // Primary Color properties
      primaryColor900: Color.lerp(primaryColor900, other.primaryColor900, t)!,
      primaryColor800: Color.lerp(primaryColor800, other.primaryColor800, t)!,
      primaryColor700: Color.lerp(primaryColor700, other.primaryColor700, t)!,
      primaryColor600: Color.lerp(primaryColor600, other.primaryColor600, t)!,
      primaryColor500: Color.lerp(primaryColor500, other.primaryColor500, t)!,
      primaryColor400: Color.lerp(primaryColor400, other.primaryColor400, t)!,
      primaryColor300: Color.lerp(primaryColor300, other.primaryColor300, t)!,
      primaryColor200: Color.lerp(primaryColor200, other.primaryColor200, t)!,
      primaryColor100: Color.lerp(primaryColor100, other.primaryColor100, t)!,
      primaryColor25: Color.lerp(primaryColor25, other.primaryColor25, t)!,

      // Black Color properties
      blackColor900: Color.lerp(blackColor900, other.blackColor900, t)!,
      blackColor800: Color.lerp(blackColor800, other.blackColor800, t)!,
      blackColor700: Color.lerp(blackColor700, other.blackColor700, t)!,
      blackColor600: Color.lerp(blackColor600, other.blackColor600, t)!,
      blackColor500: Color.lerp(blackColor500, other.blackColor500, t)!,
      blackColor400: Color.lerp(blackColor400, other.blackColor400, t)!,
      blackColor300: Color.lerp(blackColor300, other.blackColor300, t)!,
      blackColor200: Color.lerp(blackColor200, other.blackColor200, t)!,
      blackColor100: Color.lerp(blackColor100, other.blackColor100, t)!,
      blackColor50: Color.lerp(blackColor50, other.blackColor50, t)!,
      blackColor25: Color.lerp(blackColor25, other.blackColor25, t)!,

      // Error Color properties
      errorColor900: Color.lerp(errorColor900, other.errorColor900, t)!,
      errorColor800: Color.lerp(errorColor800, other.errorColor800, t)!,
      errorColor700: Color.lerp(errorColor700, other.errorColor700, t)!,
      errorColor600: Color.lerp(errorColor600, other.errorColor600, t)!,
      errorColor500: Color.lerp(errorColor500, other.errorColor500, t)!,
      errorColor400: Color.lerp(errorColor400, other.errorColor400, t)!,
      errorColor300: Color.lerp(errorColor300, other.errorColor300, t)!,
      errorColor200: Color.lerp(errorColor200, other.errorColor200, t)!,
      errorColor100: Color.lerp(errorColor100, other.errorColor100, t)!,
      errorColor50: Color.lerp(errorColor50, other.errorColor50, t)!,
      errorColor25: Color.lerp(errorColor25, other.errorColor25, t)!,
    );
  }

  // Light theme instance
  static const light = PrayerTimeThemeColor(
    // Existing properties
    scaffoldBachgroundColor: PrayerTimeAppColor.scaffoldBachgroundColor,
    primaryColor: PrayerTimeAppColor.primaryColor,
    whiteColor: PrayerTimeAppColor.whiteColor,
    backgroundColor: PrayerTimeAppColor.backgroundColor,
    modalBgColor: PrayerTimeAppColor.modalBgColor,
    tapGroupBgColor: PrayerTimeAppColor.tapGroupBgColor,
    tabActiveColor: PrayerTimeAppColor.tabActiveColor,
    borderColor: PrayerTimeAppColor.borderColor,
    titleColor: PrayerTimeAppColor.titleColor,
    subTitleColor: PrayerTimeAppColor.subTitleColor,
    bodyColor: PrayerTimeAppColor.bodyColor,
    placeHolderColor: PrayerTimeAppColor.placeHolderColor,
    linkColor: PrayerTimeAppColor.linkColor,
    buttonColor: PrayerTimeAppColor.buttonColor,
    buttonBgColor: PrayerTimeAppColor.buttonBgColor,
    captionColor: PrayerTimeAppColor.captionColor,
    disableColor: PrayerTimeAppColor.disableColor,
    successColor: PrayerTimeAppColor.successColor,
    warningColor: PrayerTimeAppColor.warningColor,
    errorColor: PrayerTimeAppColor.errorColor,

    // Primary Color properties
    primaryColor900: PrayerTimeAppColor.primaryColor900,
    primaryColor800: PrayerTimeAppColor.primaryColor800,
    primaryColor700: PrayerTimeAppColor.primaryColor700,
    primaryColor600: PrayerTimeAppColor.primaryColor600,
    primaryColor500: PrayerTimeAppColor.primaryColor500,
    primaryColor400: PrayerTimeAppColor.primaryColor400,
    primaryColor300: PrayerTimeAppColor.primaryColor300,
    primaryColor200: PrayerTimeAppColor.primaryColor200,
    primaryColor100: PrayerTimeAppColor.primaryColor100,
    primaryColor25: PrayerTimeAppColor.primaryColor25,

    // Black Color properties
    blackColor900: PrayerTimeAppColor.blackColor900,
    blackColor800: PrayerTimeAppColor.blackColor800,
    blackColor700: PrayerTimeAppColor.blackColor700,
    blackColor600: PrayerTimeAppColor.blackColor600,
    blackColor500: PrayerTimeAppColor.blackColor500,
    blackColor400: PrayerTimeAppColor.blackColor400,
    blackColor300: PrayerTimeAppColor.blackColor300,
    blackColor200: PrayerTimeAppColor.blackColor200,
    blackColor100: PrayerTimeAppColor.blackColor100,
    blackColor50: PrayerTimeAppColor.blackColor50,
    blackColor25: PrayerTimeAppColor.blackColor25,

    // Error Color properties
    errorColor900: PrayerTimeAppColor.errorColor900,
    errorColor800: PrayerTimeAppColor.errorColor800,
    errorColor700: PrayerTimeAppColor.errorColor700,
    errorColor600: PrayerTimeAppColor.errorColor600,
    errorColor500: PrayerTimeAppColor.errorColor500,
    errorColor400: PrayerTimeAppColor.errorColor400,
    errorColor300: PrayerTimeAppColor.errorColor300,
    errorColor200: PrayerTimeAppColor.errorColor200,
    errorColor100: PrayerTimeAppColor.errorColor100,
    errorColor50: PrayerTimeAppColor.errorColor50,
    errorColor25: PrayerTimeAppColor.errorColor25,
  );
}
