# Changelog

## 1.1.0 - Unreleased

## 1.0.5

* Add canonical offline JSON translation files for `ar`, `bg`, `en`, `tr`, `bs_BA`, `mk_MK`, `sq_AL`, and `sq_XK`
* Add locale alias resolution — short codes (`bs`, `mk`, `sq`), regional variants (`en_US`, `tr_TR`), and full names (`english`, `turkish`) all resolve correctly
* Add `getSupportedLanguages()` to expose the list of canonical locale codes
* Add in-memory cache for `getNames()` — repeated calls for the same locale skip asset re-loading
* `getRandomName()` now throws a descriptive `StateError` when no data is available
* Rename translation map key `description` → `translation` for consistency (**breaking** for consumers reading this key)
* Add unit tests in `test/esmaulhusna_base_test.dart`
* Update package description and pub.dev topics for better discoverability
* Fix `issue_tracker` URL

## 1.0.3

* First stable release
* Added more comprehensive language support
* Optimized performance for name retrieval
* Improved error handling and user feedback
* Updated documentation with detailed usage examples
* Ensured compatibility with latest Flutter versions
* Fixed all known bugs from previous versions

## 0.0.5

* Improved translation accuracy for existing languages
* Enhanced error handling for invalid language codes
* Added new method `getSupportedLanguages()` to get available translations
* Updated documentation with new language examples
* Performance optimizations for name retrieval
* Added proper null safety support
* Improved code documentation and examples

## 0.0.4

* Added new `getRandomName` method for random name selection
* Improved error handling in translation loading
* Added comprehensive test suite
* Updated documentation with new examples
* Fixed asset loading in package environment
* Added GitHub Actions for automated publishing
* Minor documentation updates to reflect the changes in the Arabic names
* Improved error handling for translation loading
* Added proper asset bundling support
* Major API changes for better async support:

  ```dart
  // New async API for getting names
  final names = await EsmaulHusna.getNames('bg');
  final randomName = await EsmaulHusna.getRandomName('bg');
  ```

* Added support for structured JSON translations
* Improved asset loading for package usage
* Fixed file path issues when used as a package
* Updated translation file naming convention to `{language}_name_value.json`

## 0.0.2+1

* Fixed package name from 'esmaulhusna_muslimbg' to 'esmaulhusna_muslimbg'
* Updated documentation with detailed usage examples:

  ```dart
  // Get specific name
  final names = await EsmaulHusna.getNames('en');
  print(names[0]['name']); // Returns: The Most Gracious
  print(names[0]['arabic']);  // Returns: الرَّحْمَنُ
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
  final englishNames = await EsmaulHusna.getNames('en'); 
  final turkishNames = await EsmaulHusna.getNames('tr');
  final bulgarianNames = await EsmaulHusna.getNames('bg');
  ```

* Each name entry now contains:

  ```dart
  {
    'arabic': 'Arabic text of the name',
    'name': 'Name in requested language',
    'translation': 'Description/meaning in requested language'
  }
  ```

## 0.0.1

* Initial release with basic functionality
* Support for English, Arabic, Turkish, and Bulgarian translations
* Basic error handling and input validation
