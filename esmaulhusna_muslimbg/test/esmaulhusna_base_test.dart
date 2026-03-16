import 'package:esmaulhusna_muslimbg/esmaulhusna_muslimbg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('EsmaulHusna', () {
    test('lists canonical supported languages', () {
      expect(
        EsmaulHusna.getSupportedLanguages(),
        containsAll(<String>[
          'ar',
          'bg',
          'en',
          'tr',
          'bs_BA',
          'mk_MK',
          'sq_AL',
          'sq_XK',
        ]),
      );
    });

    test('loads English data for locale compatibility files', () async {
      final englishNames = await EsmaulHusna.getNames('en');
      final bosnianNames = await EsmaulHusna.getNames('bs_BA');
      final albanianNames = await EsmaulHusna.getNames('sq_XK');

      expect(englishNames, isNotEmpty);
      expect(bosnianNames.first['name'], englishNames.first['name']);
      expect(
        albanianNames.first['translation'],
        englishNames.first['translation'],
      );
    });

    test('supports short language aliases', () async {
      final bosnianNames = await EsmaulHusna.getNames('bs');
      final macedonianNames = await EsmaulHusna.getNames('mk');

      expect(bosnianNames, isNotEmpty);
      expect(macedonianNames, isNotEmpty);
    });
  });
}
