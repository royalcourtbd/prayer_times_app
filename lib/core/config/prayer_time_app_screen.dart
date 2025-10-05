import 'package:flutter/cupertino.dart';
import 'package:salat_times/core/utility/logger_utility.dart';
import 'package:salat_times/presentation/prayer_times.dart';

/// Utility class for retrieving the screen dimensions of the device.
///
/// The `PrayerTimeAppScreen` class provides static methods and properties to access
/// the width and height of the device's screen. It relies on the `Get` package
/// to obtain the screen dimensions.
///
///
/// Example usage:
///
/// ```dart
/// PrayerTimeAppScreen.setUp();
/// double screenWidth = PrayerTimeAppScreen.width;
/// double screenHeight = PrayerTimeAppScreen.height;
/// ```
///
/// Rationale:
///
/// - The `PrayerTimeAppScreen` class provides a convenient way to access the screen dimensions
/// of the device. By centralizing the screen dimension retrieval logic within a class,
/// it promotes code re-usability and improves code readability.
///
/// - The class utilizes the `Get` package, which is a popular package for state management
/// and navigation in Flutter applications. By relying on a well-established package,
/// the `PrayerTimeAppScreen` class benefits from its reliability and compatibility with different
/// screen sizes and orientations.
///
/// - The `setUp` method allows for explicit initialization of the screen dimensions. This
/// ensures that the dimensions are retrieved only when needed and avoids unnecessary
/// calculations or potential errors caused by accessing uninitialized values.
///
/// - The `_resetIfInvalid` method checks if the screen dimensions are valid. If the dimensions
/// are less than 10 pixels in either width or height, an error is logged, and the dimensions
/// are set to `null`. This prevents the usage of invalid or unreliable screen dimensions
/// throughout the application.
///
///

class PrayerTimeAppScreen {
  PrayerTimeAppScreen._();

  static void setUp(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    _height = size.height;
    _width = size.width;
    _resetIfInvalid();
  }

  static double? _width;
  static double? _height;

  static Size get _size => MediaQuery.sizeOf(PrayerTimes.globalContext);

  static double get width {
    _width ??= _size.width;
    return _width!;
  }

  static double get height {
    _height ??= _size.height;
    return _height!;
  }

  static void _resetIfInvalid() {
    if (_width! < 10 || _height! < 10) {
      logErrorStatic(
        'PrayerTimeAppScreen size not initialized. Please initialize PrayerTimeAppScreen and try again.',
        "PrayerTimeApp",
      );
      _width = null;
      _height = null;
    }
  }
}

extension PrayerTimeAppScreenWidth on Widget {
  static double? _onePercentWidth;

  double get onePercentWidth {
    const double onePercent = 0.01;
    _onePercentWidth ??= PrayerTimeAppScreen.width * onePercent;
    return _onePercentWidth!;
  }

  static double? _twoPercentWidth;

  double get twoPercentWidth {
    const double twoPercent = 0.02;
    _twoPercentWidth ??= PrayerTimeAppScreen.width * twoPercent;
    return _twoPercentWidth!;
  }

  static double? _fiftyPercentHeight;

  double get fiftyPercentHeight {
    const double fiftyPercent = 0.50;
    _fiftyPercentHeight ??= PrayerTimeAppScreen.height * fiftyPercent;
    return _fiftyPercentHeight!;
  }

  static double? _threePercentWidth;

  double get threePercentWidth {
    const double threePercent = 0.03;
    _threePercentWidth ??= PrayerTimeAppScreen.width * threePercent;
    return _threePercentWidth!;
  }

  static double? _fourPercentWidth;

  double get fourPercentWidth {
    _fourPercentWidth ??= 4.percentWidth;
    return _fourPercentWidth!;
  }

  static double? _fivePercentWidth;

  double get fivePercentWidth {
    _fivePercentWidth ??= 5.percentWidth;
    return _fivePercentWidth!;
  }

  static double? _sixPercentWidth;

  double get sixPercentWidth {
    const double sixPercent = 0.06;
    _sixPercentWidth ??= PrayerTimeAppScreen.width * sixPercent;
    return _sixPercentWidth!;
  }

  static double? _sevenPercentWidth;

  double get sevenPercentWidth {
    const double sevenPercent = 0.07;
    _sevenPercentWidth ??= PrayerTimeAppScreen.width * sevenPercent;
    return _sevenPercentWidth!;
  }

  static double? _eightPercentWidth;

  double get eightPercentWidth {
    const double eightPercent = 0.08;
    _eightPercentWidth ??= PrayerTimeAppScreen.width * eightPercent;
    return _eightPercentWidth!;
  }

  static double? _tenPercentWidth;

  double get tenPercentWidth {
    const double tenPercentWidth = 0.10;
    _tenPercentWidth ??= PrayerTimeAppScreen.width * tenPercentWidth;
    return _tenPercentWidth!;
  }

  static double? _fortyPercentWidth;

  double get fortyPercentWidth {
    const double fortyPercent = 0.40;
    _fortyPercentWidth ??= PrayerTimeAppScreen.width * fortyPercent;
    return _fortyPercentWidth!;
  }

  static double? _thirtyPercentWidth;

  double get thirtyPercentWidth {
    const double thirtyPercentWidth = 0.32;
    _thirtyPercentWidth ??= PrayerTimeAppScreen.width * thirtyPercentWidth;
    return _thirtyPercentWidth!;
  }

  static double? _sixtySixPercentWidth;

  double get sixtySixPercentWidth {
    _sixtySixPercentWidth ??= 66.percentWidth;
    return _sixtySixPercentWidth!;
  }

  static double? _fiftyFivePercentWidth;

  double get fiftyFivePercentWidth {
    _fiftyFivePercentWidth ??= 55.percentWidth;
    return _fiftyFivePercentWidth!;
  }

  static double? _seventyPercentWidth;

  double get seventyPercentWidth {
    const double seventyPercent = 0.70;
    _seventyPercentWidth ??= PrayerTimeAppScreen.width * seventyPercent;
    return _seventyPercentWidth!;
  }

  static double? _tweentyEightPercentWidth;

  double get tweentyEightPercentWidth {
    const double tweentyEightPercentWidth = 0.28;
    _tweentyEightPercentWidth ??=
        PrayerTimeAppScreen.width * tweentyEightPercentWidth;
    return _tweentyEightPercentWidth!;
  }

  static double? _twentyPercentWidth;

  double get twentyPercentWidth {
    const double twentyPercentWidth = 0.20;
    _twentyPercentWidth ??= PrayerTimeAppScreen.width * twentyPercentWidth;
    return _twentyPercentWidth!;
  }

  static double? _twentyFivePercentWidth;

  double get twentyFivePercentWidth {
    const double twentyFivePercentWidth = 0.25;
    _twentyFivePercentWidth ??=
        PrayerTimeAppScreen.width * twentyFivePercentWidth;
    return _twentyFivePercentWidth!;
  }

  static double? _twentySixPercentWidth;

  double get twentySixPercentWidth {
    const double twentySixPercentWidth = 0.26;
    _twentySixPercentWidth ??=
        PrayerTimeAppScreen.width * twentySixPercentWidth;
    return _twentySixPercentWidth!;
  }

  static double? _twentyThreePercentWidth;

  double get twentyThreePercentWidth {
    const double twentyThreePercentWidth = 0.23;
    _twentyThreePercentWidth ??=
        PrayerTimeAppScreen.width * twentyThreePercentWidth;
    return _twentyThreePercentWidth!;
  }

  static double? _fourtyPercentWidth;

  double get fourtyPercentWidth {
    const double fourtyPercentWidth = 0.40;
    _fourtyPercentWidth ??= PrayerTimeAppScreen.width * fourtyPercentWidth;
    return _fourtyPercentWidth!;
  }

  static double? _twentyPercentHeight;

  double get twentyPercentHeight {
    const double twentyPercent = 0.20;
    _twentyPercentHeight ??= PrayerTimeAppScreen.height * twentyPercent;
    return _twentyPercentHeight!;
  }

  static double? _tenPercentHeight;

  double get tenPercentHeight {
    const double tenPercentHeight = 0.10;
    _tenPercentHeight ??= PrayerTimeAppScreen.height * tenPercentHeight;
    return _tenPercentHeight!;
  }

  static double? _twelvePercentHeight;

  double get twelvePercentHeight {
    const double twentyPercent = 0.12;
    _twelvePercentHeight ??= PrayerTimeAppScreen.height * twentyPercent;
    return _twelvePercentHeight!;
  }

  static double? _fourteenPercentHeight;

  double get fourteenPercentHeight {
    const double fourteenPercentHeight = 0.14;
    _fourteenPercentHeight ??=
        PrayerTimeAppScreen.height * fourteenPercentHeight;
    return _fourteenPercentHeight!;
  }

  static double? _tweentyPercentHeight;

  double get tweentyPercentHeight {
    const double tweentyPercentHeight = 0.20;
    _tweentyPercentHeight ??= PrayerTimeAppScreen.height * tweentyPercentHeight;
    return _tweentyPercentHeight!;
  }
}

double? _tenPx;

// unreadable code, you say? I say, it's a work of art
// bro, performance matters
double get tenPx {
  _tenPx ??= 10.px;
  return _tenPx!;
}

double? _fourteenPx;

double get fourteenPx {
  _fourteenPx ??= 14.px;
  return _fourteenPx!;
}

double? _threePx;

double get threePx {
  _threePx ??= 3.px;
  return _threePx!;
}

double? _eightPx;

double get eightPx {
  _eightPx ??= 8.px;
  return _eightPx!;
}

double? _ninePx;

double get ninePx {
  _ninePx ??= 9.px;
  return _ninePx!;
}

double? _fourPx;

double get fourPx {
  _fourPx ??= 4.px;
  return _fourPx!;
}

double? _eighteenPx;

double get eighteenPx {
  _eighteenPx ??= 18.px;
  return _eighteenPx!;
}

double? _nineteenPx;

double get nineteenPx {
  _nineteenPx ??= 19.px;
  return _nineteenPx!;
}

double? _seventeenPx;

double get seventeenPx {
  _seventeenPx ??= 17.px;
  return _seventeenPx!;
}

double? _fiftyPx;

double get fiftyPx {
  _fiftyPx ??= 50.px;
  return _fiftyPx!;
}

double? _fiftyFivePx;

double get fiftyFivePx {
  _fiftyFivePx ??= 55.px;
  return _fiftyFivePx!;
}

double? _sixtyFivePx;

double get sixtyFivePx {
  _sixtyFivePx ??= 65.px;
  return _sixtyFivePx!;
}

double? _seventyPx;

double get seventyPx {
  _seventyPx ??= 70.px;
  return _seventyPx!;
}

double? _hundredPx;

double get hundredPx {
  _hundredPx ??= 100.px;
  return _hundredPx!;
}

double? _hundredFifteenPx;

double get hundredFifteenPx {
  _hundredFifteenPx ??= 115.px;
  return _hundredFifteenPx!;
}

double? _hundredFivePx;

double get hundredFivePx {
  _hundredFivePx ??= 105.px;
  return _hundredFivePx!;
}

double? _hundredTweentyPx;

double get hundredTweentyPx {
  _hundredTweentyPx ??= 120.px;
  return _hundredTweentyPx!;
}

double? _animationAppbarHeight;

double get animationAppbarHeight {
  _animationAppbarHeight ??= 130.px;
  return _animationAppbarHeight!;
}

double? _subtitleAppbarHeight;

double get subtitleAppbarHeight {
  _subtitleAppbarHeight ??= 112.px;
  return _subtitleAppbarHeight!;
}

double? _hundredTenPx;

double get hundredTenPx {
  _hundredTenPx ??= 110.px;
  return _hundredTenPx!;
}

double? _hundredThreePx;

double get hundredThreePx {
  _hundredThreePx ??= 103.px;
  return _hundredThreePx!;
}

double? _ninetyPx;

double get ninetyPx {
  _ninetyPx ??= 90.px;
  return _ninetyPx!;
}

double? _twentyPx;

double get twentyPx {
  _twentyPx ??= 20.px;
  return _twentyPx!;
}

double? _twentyTwoPx;

double get twentyTwoPx {
  _twentyTwoPx ??= 22.px;
  return _twentyTwoPx!;
}

double? _twentyFivePx;

double get twentyFivePx {
  _twentyFivePx ??= 25.px;
  return _twentyFivePx!;
}

double? _elevenPx;

double get elevenPx {
  _elevenPx ??= 11.px;
  return _elevenPx!;
}

double? _twelvePx;

double get twelvePx {
  _twelvePx ??= 12.px;
  return _twelvePx!;
}

double? _sixPx;

double get sixPx {
  _sixPx ??= 6.px;
  return _sixPx!;
}

double? _sixteenPx;

double get sixteenPx {
  _sixteenPx ??= 16.px;
  return _sixteenPx!;
}

double? _sevenPx;

double get sevenPx {
  _sevenPx ??= 7.px;
  return _sevenPx!;
}

double? _fortySixPx;

double get fortySixPx {
  _fortySixPx ??= 46.px;
  return _fortySixPx!;
}

double? _fifteenPx;

double get fifteenPx {
  _fifteenPx ??= 15.px;
  return _fifteenPx!;
}

double? _twentyOnePx;

double get twentyOnePx {
  _twentyOnePx ??= 21.px;
  return _twentyOnePx!;
}

double? _twentyThreePx;

double get twentyThreePx {
  _twentyThreePx ??= 23.px;
  return _twentyThreePx!;
}

double? _twentyFourPx;

double get twentyFourPx {
  _twentyFourPx ??= 24.px;
  return _twentyFourPx!;
}

double? _thirteenPx;

double get thirteenPx {
  _thirteenPx ??= 13.px;
  return _thirteenPx!;
}

double? _thirtyTwoPx;

double get thirtyTwoPx {
  _thirtyTwoPx ??= 32.px;
  return _thirtyTwoPx!;
}

double? _thirtyFivePx;

double get thirtyFivePx {
  _thirtyFivePx ??= 35.px;
  return _thirtyFivePx!;
}

double? _thirtySevenPx;

double get thirtySevenPx {
  _thirtySevenPx ??= 37.px;
  return _thirtySevenPx!;
}

double? _fortyTwoPx;

double get fortyTwoPx {
  _fortyTwoPx ??= 42.px;
  return _fortyTwoPx!;
}

double? _fortyFourPx;

double get fortyFourPx {
  _fortyFourPx ??= 44.px;
  return _fortyFourPx!;
}

double? _fortyPx;

double get fortyPx {
  _fortyPx ??= 40.px;
  return _fortyPx!;
}

double? _fortyOnePx;

double get fortyOnePx {
  _fortyOnePx ??= 41.px;
  return _fortyOnePx!;
}

double? _thirtyNinePx;

double get thirtyNinePx {
  _thirtyNinePx ??= 39.px;
  return _thirtyNinePx!;
}

double? _fortyFivePx;

double get fortyFivePx {
  _fortyFivePx ??= 45.px;
  return _fortyFivePx!;
}

double? _sixtyPx;

double get sixtyPx {
  _sixtyPx ??= 65.px;
  return _sixtyPx!;
}

double? _seventyFivePx;

double get seventyFivePx {
  _seventyFivePx ??= 75.px;
  return _seventyFivePx!;
}

double? _eightyPx;

double get eightyPx {
  _eightyPx ??= 80.px;
  return _eightyPx!;
}

double? _eightyFivePx;

double get eightyFivePx {
  _eightyFivePx ??= 85.px;
  return _eightyFivePx!;
}

double? _fivePx;

double get fivePx {
  _fivePx ??= 5.px;
  return _fivePx!;
}

double? _twoPx;

double get twoPx {
  _twoPx ??= 2.px;
  return _twoPx!;
}

double? _thirtyPx;

double get thirtyPx {
  _thirtyPx ??= 30.px;
  return _thirtyPx!;
}

double? _twentySixPx;

double get twentySixPx {
  _twentySixPx ??= 26.px;
  return _twentySixPx!;
}

double? _twentySevenPx;

double get twentySevenPx {
  _twentySevenPx ??= 27.px;
  return _twentySevenPx!;
}

double? _heightPercent;
double? _widthPercent;
double? prayerTimeAppScreenWidthQuarterPercentage;

/// A set of extensions for numerical types that provide convenience methods for
/// converting values to specific units based on the device's screen dimensions.
///
///
/// Example usage:
///
/// ```dart
/// double fontSizeInPixels = 16.px;
/// double containerHeightInPercentage = 50.percentHeight;
/// double containerWidthInPercentage = 75.percentWidth;
/// ```
///
/// Rationale:
///
/// - The `DeviceExt` extension provides convenience methods for converting numerical values
/// to specific units based on the device's screen dimensions. By encapsulating the conversion logic
/// within extension methods, it promotes code reusability and improves code readability.
///
/// - The extension methods `px`, `percentHeight`, and `percentWidth` allow developers to express
/// sizes or positions in a more intuitive and adaptable way, based on the device's screen size.
///
/// - By calculating the conversion factors only once and storing them in variables (`_heightPercent`,
/// `_widthPercent`, and `_PrayerTimeAppScreenWidthQuarterPercentage`), subsequent conversions for the same
/// type of unit can be performed efficiently without the need for repeated calculations.
extension DeviceExt on num {
  /// The `px` method converts a numerical value to pixels by multiplying it with a factor
  /// representing a quarter of the screen width percentage. The factor is calculated using the
  /// `_calculatePrayerTimeAppScreenWidthQuarterPercentage` function.
  ///
  ///
  /// Example usage:
  ///
  /// ```dart
  /// double fontSizeInPixels = 16.px;
  /// ```
  double get px {
    prayerTimeAppScreenWidthQuarterPercentage ??=
        _calculatePrayerTimeAppScreenWidthQuarterPercentage();
    return this * (prayerTimeAppScreenWidthQuarterPercentage ?? 0);
  }

  /// The `percentHeight` method converts a numerical value to a percentage of the device's
  /// screen height. It multiplies the numerical value with a factor representing the ratio between
  /// the device's screen height and 100. The factor is calculated once and stored in the `_heightPercent`
  /// variable.
  ///
  ///
  /// Example usage:
  ///
  /// ```dart
  /// double containerHeightInPercentage = 50.percentHeight;
  /// ```
  double get percentHeight {
    _heightPercent ??= PrayerTimeAppScreen.height / 100;
    return this * (_heightPercent ?? 0);
  }

  /// The `percentWidth` method converts a numerical value to a percentage of the device's
  /// screen width. It multiplies the numerical value with a factor representing the ratio between
  /// the device's screen width and 100. The factor is calculated once and stored in the `_widthPercent`
  /// variable.
  ///
  ///
  /// Example usage:
  ///
  /// ```dart
  /// double containerWidthInPercentage = 75.percentWidth;
  /// ```
  double get percentWidth {
    _widthPercent ??= PrayerTimeAppScreen.width / 100;
    return this * (_widthPercent ?? 0);
  }
}

/// Calculates the quarter percentage of the Tutor screen width.
///
/// The `_calculatePrayerTimeAppScreenWidthQuarterPercentage` function calculates and returns
/// a factor that represents a quarter of the Tutor screen width percentage. It is used
/// by the `px` method in the `DeviceExt` extension to convert numerical values to pixels.
/// The quarter percentage is calculated as the ratio between one-quarter of the Tutor
/// screen width and 100.
///
/// This function assumes that the `PrayerTimeAppScreen` class, containing the width property,
/// is properly defined and accessible within the scope of this function.
double _calculatePrayerTimeAppScreenWidthQuarterPercentage() {
  return (PrayerTimeAppScreen.width / 3.9) / 100;
}
