class EsmaulHusna {
  /// Get English name for given number (1-99)
  static String getEnglishName(int number) {
    if (number < 1 || number > 99) {
      throw RangeError('Number must be between 1 and 99');
    }
    return _names[number - 1]['english'] as String;
  }

  /// Get Arabic name for given number (1-99)
  static String getArabicName(int number) {
    if (number < 1 || number > 99) {
      throw RangeError('Number must be between 1 and 99');
    }
    return _names[number - 1]['arabic'] as String;
  }

  /// Get Bulgarian name for given number (1-99)
  static String getBulgarianName(int number) {
    if (number < 1 || number > 99) {
      throw RangeError('Number must be between 1 and 99');
    }
    return _names[number - 1]['bulgarian'] as String;
  }

  /// Get description for given number (1-99)
  static String getDescription(int number) {
    if (number < 1 || number > 99) {
      throw RangeError('Number must be between 1 and 99');
    }
    return _names[number - 1]['description'] as String;
  }

  /// Get list of all English names
  static List<String> getAllEnglishNames() {
    return _names.map((name) => name['english'] as String).toList();
  }

  /// Get list of all Arabic names
  static List<String> getAllArabicNames() {
    return _names.map((name) => name['arabic'] as String).toList();
  }

  /// Get list of all Bulgarian names
  static List<String> getAllBulgarianNames() {
    return _names.map((name) => name['bulgarian'] as String).toList();
  }

  static const List<Map<String, String>> _names = [
    {
      'english': 'Ar-Rahman',
      'arabic': 'الرَّحْمَنُ',
      'bulgarian': 'Всемилостивият',
      'description': 'The Most Gracious',
    },
    {
      'english': 'Ar-Raheem',
      'arabic': 'الرَّحِيمُ',
      'bulgarian': 'Милосърдният',
      'description': 'The Most Merciful',
    },
    // Add all 99 names here...
  ];
}
