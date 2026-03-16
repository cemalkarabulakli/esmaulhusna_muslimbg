import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart' show FlutterError, debugPrint;
import 'package:flutter/services.dart' show rootBundle;

class EsmaulHusna {
  static const String _assetBasePath =
      'packages/esmaulhusna_muslimbg/lib/assets/translations';

  static const List<String> _supportedLanguages = [
    'ar',
    'bg',
    'bs_BA',
    'en',
    'sq_AL',
    'tr',
  ];

  static const Map<String, String> _languageAliases = {
    'ar': 'ar',
    'arabic': 'ar',
    'ar_sa': 'ar',
    'bg': 'bg',
    'bg_bg': 'bg',
    'bulgarian': 'bg',
    'bs': 'bs_BA',
    'bs_ba': 'bs_BA',
    'bosnian': 'bs_BA',
    'en': 'en',
    'en_gb': 'en',
    'en_us': 'en',
    'english': 'en',
    'mk': 'en',
    'mk_mk': 'en',
    'macedonian': 'en',
    'sq': 'sq_AL',
    'sq_al': 'sq_AL',
    'sq_xk': 'sq_AL',
    'albanian': 'sq_AL',
    'tr': 'tr',
    'tr_tr': 'tr',
    'turkish': 'tr',
  };

  static final Map<String, Future<List<Map<String, String>>>> _cache = {};

  /// Returns the canonical locale codes supported by this package.
  static List<String> getSupportedLanguages() =>
      List.unmodifiable(_supportedLanguages);

  /// Returns a list of Esmaul Husna translations for the specified language.
  ///
  /// Common values include:
  /// - 'ar'
  /// - 'bg'
  /// - 'en'
  /// - 'tr'
  /// - 'bs_BA'
  /// - 'mk_MK'
  /// - 'sq_AL'
  /// - 'sq_XK'
  ///
  /// Returns a List of Maps containing:
  /// - 'arabic': Arabic text of the name
  /// - 'name': Translated name in specified language
  /// - 'translation': Description/meaning in specified language
  static Future<List<Map<String, String>>> getNames(String language) {
    final resolvedLanguage = _resolveLanguage(language);
    return _cache.putIfAbsent(
      resolvedLanguage,
      () => _loadTranslation(resolvedLanguage),
    );
  }

  /// Returns a random name from the Esmaul Husna dataset in the specified
  /// language.
  ///
  /// [language] parameter accepts the same values as [getNames]
  ///
  /// Returns a Map containing:
  /// - 'arabic': Arabic text of the name
  /// - 'name': Translated name in specified language
  /// - 'translation': Description/meaning in specified language
  static Future<Map<String, String>> getRandomName(String language) async {
    final names = await getNames(language);
    if (names.isEmpty) {
      throw StateError('No Esmaul Husna data available for "$language".');
    }

    final random = Random();
    return names[random.nextInt(names.length)];
  }

  static String _resolveLanguage(String language) {
    final normalizedLanguage = language.trim().replaceAll('-', '_');
    if (normalizedLanguage.isEmpty) {
      return 'en';
    }

    if (_supportedLanguages.contains(normalizedLanguage)) {
      return normalizedLanguage;
    }

    return _languageAliases[normalizedLanguage.toLowerCase()] ?? 'en';
  }

  static Future<List<Map<String, String>>> _loadTranslation(
    String language,
  ) async {
    try {
      final jsonString = await _loadTranslationJson(language);
      final jsonTranslations = jsonDecode(jsonString) as Map<String, dynamic>;
      final numericKeys =
          jsonTranslations.keys.map(int.tryParse).whereType<int>().toList()
            ..sort();

      return numericKeys.map((key) {
        final translation = jsonTranslations[key.toString()];
        if (translation is Map) {
          return {
            'arabic': translation['arabic'] as String? ?? '',
            'name': translation['name'] as String? ?? '',
            'translation': translation['translation'] as String? ?? '',
          };
        }

        return {
          'arabic': translation?.toString() ?? '',
          'name': '',
          'translation': '',
        };
      }).toList(growable: false);
    } catch (e) {
      debugPrint('Error loading translations for $language: $e');
      return const [];
    }
  }

  static Future<String> _loadTranslationJson(String language) async {
    final assetCandidates = [
      '$_assetBasePath/$language.json',
      '$_assetBasePath/${language}_esmaulhusna.json',
    ];

    for (final assetPath in assetCandidates) {
      try {
        return await rootBundle.loadString(assetPath);
      } on FlutterError {
        continue;
      }
    }

    if (language != 'en') {
      return _loadTranslationJson('en');
    }

    throw FlutterError('Unable to load translation assets for "$language".');
  }
}
