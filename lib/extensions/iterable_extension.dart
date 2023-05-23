
extension IterableExtension<T> on List<T> {
  T? elementAtOrNull(int index) {
    if (index >= 0 && index < length) {
      return this[index];
    } else {
      return null;
    }
  }
}
