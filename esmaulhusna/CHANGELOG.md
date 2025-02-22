## 0.0.2+1

* Fixed package name from 'esmaulhusna' to 'esmaulhusna_muslimbg'
* Updated documentation with detailed usage examples:
  ```dart
  // Get specific name
  print(EsmaulHusna.getEnglishName(1)); // Returns: The Most Gracious
  print(EsmaulHusna.getArabicName(1));  // Returns: الرَّحْمَنُ
  ```
* Added example app demonstrating:
  * ListView of all 99 names
  * Individual name lookup
  * Multi-language display
* Improved code organization and readability
* Performance optimizations for name retrieval
* Enhanced error handling with meaningful messages

## 0.0.2

* Added comprehensive support for multiple languages:
  ```dart
  // Example usage for all supported languages
  EsmaulHusna.getEnglishName(1);    // The Most Gracious
  EsmaulHusna.getArabicName(1);     // الرَّحْمَنُ
  EsmaulHusna.getTurkishName(1);    // Rahman
  EsmaulHusna.getBulgarianName(1);  // Всемилостивият
  ```
* Implemented complete collection of 99 Names with descriptions:
  ```dart
  // Get description
  EsmaulHusna.getDescription(1); // Returns detailed meaning and context
  ```
* Created API methods for bulk operations:
  ```dart
  List<String> allNames = EsmaulHusna.getAllEnglishNames();
  ```
* Added type safety and input validation:
  ```dart
  // Validates number range (1-99)
  if (number < 1 || number > 99) throw RangeError
  ```

## 0.0.1

* Initial release establishing foundation:
  ```dart
  // Basic name retrieval
  EsmaulHusna.getEnglishName(1);
  ```
* Core data structure implementation
* Essential API methods
* Basic documentation and README
