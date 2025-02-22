import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class EsmaulHusna {
  /// Returns a list of Esmaul Husna (99 Names of Allah) translations for the specified language
  ///
  /// [language] parameter accepts following values:
  /// - 'english': Returns English translations
  /// - 'arabic': Returns Arabic translations
  /// - 'turkish': Returns Turkish translations
  /// - 'bulgarian': Returns Bulgarian translations
  ///
  /// Returns a List of Maps containing:
  /// - 'arabic': Arabic text of the name
  /// - 'name': Translated name in specified language
  /// - 'description': Description/meaning in specified language
  static Future<List<Map<String, String>>> getNames(String language) async {
    return _loadTranslation(language);
  }

  /// Returns a random name from the 99 Names of Allah in the specified language
  ///
  /// [language] parameter accepts the same values as [getNames]
  ///
  /// Returns a Map containing:
  /// - 'arabic': Arabic text of the name
  /// - 'name': Translated name in specified language
  /// - 'description': Description/meaning in specified language
  static Future<Map<String, String>> getRandomName(String language) async {
    final names = await getNames(language);
    final random = Random();
    return names[random.nextInt(names.length)];
  }

  /// Loads and parses translations from JSON file for the specified language
  static Future<List<Map<String, String>>> _loadTranslation(
      String language) async {
    const int namesCount = 99;
    final translations = List<Map<String, String>>.generate(
      namesCount,
      (_) => const {},
    );

    try {
      final jsonString = await rootBundle.loadString(
          'packages/esmaulhusna_muslimbg/lib/assets/translations/$language.json');
      final jsonTranslations = jsonDecode(jsonString) as Map<String, dynamic>;

      for (var i = 1; i <= namesCount; i++) {
        final number = i.toString();
        if (!jsonTranslations.containsKey(number)) continue;

        final translation = jsonTranslations[number];
        translations[i - 1] = translation is Map
            ? {
                'arabic': translation['arabic'] as String? ?? '',
                'name': translation['name'] as String? ?? '',
                'translation': translation['translation'] as String? ?? '',
              }
            : {
                'arabic': translation.toString(),
                'name': '',
                'translation': '',
              };
      }
    } catch (e) {
      print('Error loading translations for $language: $e');
    }

    return translations;
  }
}
