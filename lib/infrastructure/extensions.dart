/// String extension to convert to uppercase the first letter of the string.
extension Capitalised on String {
  String get capitalised => isEmpty ? this : this[0].toUpperCase() + substring(1);
}
