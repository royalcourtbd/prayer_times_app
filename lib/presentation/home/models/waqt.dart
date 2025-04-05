// lib/presentation/prayer_time/models/waqt.dart

import 'package:prayer_times/core/static/svg_path.dart';
import 'package:prayer_times/core/utility/utility.dart';

enum WaqtType {
  fajr,
  sunrise, // Add new type
  duha, // Add new type
  dhuhr,
  asr,
  maghrib,
  isha;

  String get displayName {
    switch (this) {
      case WaqtType.fajr:
        return 'Fajr';
      case WaqtType.sunrise:
        // return 'Prohibited times';
        return 'Sunrise';
      case WaqtType.duha:
        return 'Salat Ad-Duha';
      case WaqtType.dhuhr:
        return 'Dhuhr';
      case WaqtType.asr:
        return 'Asr';
      case WaqtType.maghrib:
        return 'Maghrib';
      case WaqtType.isha:
        return 'Isha';
    }
  }

  String get icon {
    switch (this) {
      case WaqtType.fajr:
        return SvgPath.icFazrFill;
      case WaqtType.sunrise:
        return SvgPath.icAsrFill; // Need to add this icon
      case WaqtType.duha:
        return SvgPath.icDhuhrFill; // Need to add this icon
      case WaqtType.dhuhr:
        return SvgPath.icDhuhrFill;
      case WaqtType.asr:
        return SvgPath.icAsrFill;
      case WaqtType.maghrib:
        return SvgPath.icMaghribFill;
      case WaqtType.isha:
        return SvgPath.icIshaFill;
    }
  }

  bool get shouldShowInTracker {
    return this != WaqtType.sunrise && this != WaqtType.duha;
  }
}

class WaqtViewModel {
  final WaqtType type;
  final DateTime? time;
  final bool isActive;

  const WaqtViewModel({
    required this.type,
    required this.time,
    this.isActive = false,
  });

  String get displayName => type.displayName;
  String get icon => type.icon;
  String get formattedTime => getFormattedTimeForWaqtView(time);
}
