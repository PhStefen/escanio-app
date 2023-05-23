extension StringExtension on String {
  String toCamelCase() {
    return replaceFirstMapped(
      RegExp(r'.'),
      (match) => match.group(0)!.toUpperCase(),
    );
  }
}
