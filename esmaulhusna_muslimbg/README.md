# esmaulhusna_muslimbg

`esmaulhusna_muslimbg` is a Flutter `pub.dev` package for **Esmaul Husna**, **Asma ul Husna**, and the **99 Names of Allah**. It helps Flutter developers build Islamic apps, Quran apps, dua apps, prayer apps, and Balkan-language mobile experiences with offline access to Arabic names and translated meanings.

[pub.dev package](https://pub.dev/packages/esmaulhusna_muslimbg) • [GitHub repository](https://github.com/cemalkarabulakli/esmaulhusna_muslimbg)

## Why this Flutter package

- Offline JSON dataset bundled inside the package
- Arabic text included for every name
- Simple async API for `getNames` and `getRandomName`
- Locale code support for Flutter apps that use Balkan language variants
- Suitable for Muslim apps, Quran readers, zikr apps, prayer time apps, and Islamic education apps

## Supported locale codes

Native dataset files:

- `ar`
- `bg`
- `en`

Locale compatibility files included in this release:

- `tr`
- `bs_BA`
- `mk_MK`
- `sq_AL`
- `sq_XK`

Short aliases resolved by the package:

- `bs` -> `bs_BA`
- `mk` -> `mk_MK`
- `sq` -> `sq_AL`
- `english` -> `en`
- `bulgarian` -> `bg`
- `turkish` -> `tr`
- `arabic` -> `ar`

> **Note:** Only the `bg` (Bulgarian) locale has been fully tested end-to-end. The `ar` and `en` datasets are included but have not been fully verified. The `tr`, `bs_BA`, `mk_MK`, `sq_AL`, and `sq_XK` locale files are shipped so Flutter apps can support these locale codes immediately, but their content has not been tested and currently reuses the English dataset until dedicated translations are added.

## Installation

Add the package to your Flutter app:

```yaml
dependencies:
  esmaulhusna_muslimbg: ^1.0.3
```

Then run:

```bash
flutter pub get
```

## Quick start

```dart
import 'package:esmaulhusna_muslimbg/esmaulhusna_muslimbg.dart';

final supportedLanguages = EsmaulHusna.getSupportedLanguages();

final englishNames = await EsmaulHusna.getNames('en');
final bosnianNames = await EsmaulHusna.getNames('bs_BA');
final macedonianNames = await EsmaulHusna.getNames('mk_MK');
final albanianNamesKosovo = await EsmaulHusna.getNames('sq_XK');

final randomName = await EsmaulHusna.getRandomName('bg');

print(supportedLanguages);
print(randomName['arabic']);
print(randomName['name']);
print(randomName['translation']);
```

## Response shape

Each item in the returned list has this structure:

```dart
{
  'arabic': 'Arabic text of the name',
  'name': 'Localized name',
  'translation': 'Localized meaning or explanation'
}
```

## Example usage in a widget

```dart
import 'package:esmaulhusna_muslimbg/esmaulhusna_muslimbg.dart';
import 'package:flutter/material.dart';

class EsmaulHusnaList extends StatelessWidget {
  const EsmaulHusnaList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: EsmaulHusna.getNames('sq_AL'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final names = snapshot.data!;

        return ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, index) {
            final name = names[index];
            return ListTile(
              title: Text(name['name'] ?? ''),
              subtitle: Text(name['translation'] ?? ''),
              leading: Text(name['arabic'] ?? ''),
            );
          },
        );
      },
    );
  }
}
```

## Used in MuslimBG

This package is used inside the **MuslimBG** mobile app as the Esmaul Husna data source.

- Android: [MuslimBG on Google Play](https://play.google.com/store/apps/details?id=com.boboautomate.muslimbg&hl=en&gl=US)
- iOS: [MuslimBG on the App Store](https://apps.apple.com/app/id6467431798)

## v1.1.0 roadmap

- Stabilize locale support for `bg`, `en`, `tr`, `bs_BA`, `mk_MK`, `sq_AL`, and `sq_XK`
- Add a typed `EsmaulHusnaName` model instead of raw maps
- Add `getByIndex`, search, and filtering helpers
- Export production-ready widgets for list, grid, and detail layouts
- Replace English fallback content with dedicated Turkish, Bosnian, Macedonian, and Albanian translations
- Expand automated tests and CI checks for asset consistency

## Repository and package keywords

If you are searching for a Flutter package for **Esmaul Husna**, **Asma ul Husna**, **99 Names of Allah**, **Islamic Flutter package**, **Quran app package**, or **Balkan localization in Flutter**, this package is designed for that use case.

## License

MIT
