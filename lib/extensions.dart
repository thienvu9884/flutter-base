// Parse double from string.
// Ex1: '1.0'.toDouble(); // With default value is 0.0 when parse error.
// Ex2: '1.0'.toDouble(2.0); // With default value is 2.0 when parse error.
// Lower first letter of String
// Upper first letter of String
extension StringX on String {

  // Parse double from String
  double toDouble([double defaultValue = 0.0]) =>
      double.tryParse(replaceAll(RegExp(r'[^0-9\.]'), '')) ?? defaultValue;

  // Lower first letter
  String lowerFirst() => this[0].toLowerCase() + substring(1, length);

  // Upper first letter
  String upperFirst() => this[0].toUpperCase() + substring(1, length);
}
