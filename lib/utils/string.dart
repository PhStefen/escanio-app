class StringUtils {
  static String toCamelCase(String text) {
    return text.replaceFirstMapped(
      RegExp(r'.'),
      (match) => match.group(0)!.toUpperCase(),
    );
  }
}
