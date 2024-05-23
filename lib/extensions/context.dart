import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  bool get isDark => MediaQuery.of(this).platformBrightness == Brightness.dark;
  double get deviceWidth => MediaQuery.of(this).size.width;
  double get deviceHeight => MediaQuery.of(this).size.height;
  double get bottomSafeArea => MediaQuery.of(this).padding.bottom;
  double get topSafeArea => MediaQuery.of(this).padding.top;
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  TextStyle get titleStyle => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get subtitleStyle => Theme.of(this).textTheme.titleMedium!;
  TextStyle get bodyStyle => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get smallStyle => Theme.of(this).textTheme.bodySmall!;
  TextStyle get verySmallStyle =>
      Theme.of(this).textTheme.bodySmall!.copyWith(fontSize: 10);
  bool get isIphoneMiniSize =>
      deviceWidth == 320 && deviceHeight == 568; // iPhone SE 1st
  double get appBarHeight => MediaQuery.of(this).padding.top + kToolbarHeight;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
}
