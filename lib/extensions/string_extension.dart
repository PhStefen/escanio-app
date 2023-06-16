import 'package:diacritic/diacritic.dart';

extension StringExtension on String {
  String toCamelCase() {
    return replaceFirstMapped(
      RegExp(r'.'),
      (match) => match.group(0)!.toUpperCase(),
    );
  }

  String normalize() => removeDiacritics(toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' '));
}
