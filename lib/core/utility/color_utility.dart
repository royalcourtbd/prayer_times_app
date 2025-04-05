import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/external_libs/lru_map/lru_map.dart';
import 'package:qibla_and_prayer_times/data/services/running_compute.dart';

import 'trial_utility.dart';

Future<Color> Function(String) getColorFromHexAsync = (String hexColor) async {
  final Color color = await compute(getColorFromHex, hexColor);
  return color;
};

final Map<String, Color> _getColorFromHexCache = LruMap(maximumSize: 12);

/// Takes a hexadecimal color code as a [String], and returns
/// the corresponding [Color]. If the provided [hexColor] is null or an empty
/// [String], the function returns [Colors.transparent]. If the provided [hexColor]
/// has been previously passed to this function, the function will return the
/// previously generated [Color] instead of creating a new one.
///
/// The [hexColor] parameter should be a string that represents the hexadecimal
/// representation of a color, with or without the '#' prefix. The function expects
/// the hex string to be in the format 'RRGGBB' or 'AARRGGBB' where RR, GG, BB, and
/// AA are hexadecimal values for the red, green, blue, and alpha components of the color,
/// respectively. If the provided string has fewer than 8 characters, the missing components
/// are assumed to be fully opaque, i.e., the function appends 'FF' to the string.
///
/// If the provided [hexColor] string is not valid or cannot be parsed as a hexadecimal
/// color code, the function returns [Colors.transparent]. This function utilizes
/// the [_getColorFromHexCache] map to store previously generated colors, and thus
/// subsequent calls with the same [hexColor] will return the cached color without
/// re-parsing the string.
///
/// Example usage:
///
/// ```dart
///
/// Color red = getColorFromHex('FF0000');
///
/// Color transparent = getColorFromHex(null);
///
/// ```
///
///

Color Function(String?) getColorFromHex = (String? hexColor) {
  final Color? color = catchAndReturn(() {
    if (hexColor == null) return Colors.transparent;
    if (hexColor.isEmpty) return Colors.transparent;

    if (_getColorFromHexCache.containsKey(hexColor)) {
      return _getColorFromHexCache[hexColor]!;
    }
    final String validHexColor = hexColor.replaceAll("#", "");
    final String hexColorWithAlpha = validHexColor.padLeft(8, 'F');
    final int colorInt = int.parse(
      hexColorWithAlpha.contains("0x")
          ? hexColorWithAlpha
          : "0x$hexColorWithAlpha",
    );
    final Color color = Color(colorInt);
    _getColorFromHexCache[hexColor] = color;
    return color;
  });
  return color ?? Colors.transparent;
};

/// Returns a hexadecimal string representation of the given [color].
///
/// If the input color is null, the returned string is '#00000000'.
///
/// Example usage:
///
/// ```dart
///
/// final Color red = Colors.red;
/// String hex = getHexFromColor(red); // '#FFFF0000'
///
/// ```
/// Throws an error if the conversion fails for any reason.
///
/// Implementation note: This function converts a color's 32-bit integer value
/// to an 8-digit hexadecimal string in the form #AARRGGBB, where AA represents
/// the alpha value, RR represents the red value, GG represents the green value,
/// and BB represents the blue value. The toUpperCase() method is called on the
/// resulting string to ensure that the hex digits are in upper case. If the alpha
/// value is not specified, 'FF' is used as the default value. If the color
/// conversion fails, an error is thrown.
String Function(Color) getHexFromColor = (Color color) {
  return catchAndReturn(() {
        final int r = (color.r * 255).toInt();
        final int g = (color.g * 255).toInt();
        final int b = (color.b * 255).toInt();

        final int colorInt = (r << 16) | (g << 8) | b;
        final String hexColor = colorInt.toRadixString(16).padLeft(6, '0');

        return "#$hexColor".toUpperCase();
      }) ??
      "#FF66BB6A";
};
