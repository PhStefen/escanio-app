import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;
  String get logoPath =>
      isDarkMode ? "images/logo_dark_mode.svg" : "images/logo_light_mode.svg";

  ThemeData get theme => Theme.of(this);
}
