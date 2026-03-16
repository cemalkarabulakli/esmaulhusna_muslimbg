# esmaulhusna_muslimbg

[![pub package](https://img.shields.io/pub/v/esmaulhusna_muslimbg.svg)](https://pub.dev/packages/esmaulhusna_muslimbg)
[![pub points](https://img.shields.io/pub/points/esmaulhusna_muslimbg)](https://pub.dev/packages/esmaulhusna_muslimbg/score)
[![likes](https://img.shields.io/pub/likes/esmaulhusna_muslimbg)](https://pub.dev/packages/esmaulhusna_muslimbg/score)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A Flutter package providing the **99 Names of Allah** (Esmaul Husna / Asma ul Husna) with Arabic text and meanings — fully offline, no internet required.

Designed for Islamic apps, Quran readers, dua apps, zikr apps, prayer-time apps, and Flutter apps targeting Balkan Muslim communities.

[pub.dev](https://pub.dev/packages/esmaulhusna_muslimbg) • [GitHub](https://github.com/cemalkarabulakli/esmaulhusna_muslimbg) • [Issues](https://github.com/cemalkarabulakli/esmaulhusna_muslimbg/issues)

---

## Features

- Fully offline — JSON assets bundled inside the package, no network calls
- Arabic text for all 99 names
- 8 locale datasets: `ar`, `bg`, `en`, `tr`, `bs_BA`, `mk_MK`, `sq_AL`, `sq_XK`
- Flexible locale input — accepts short codes, regional variants, and full language names
- In-memory caching — repeated calls to `getNames()` load assets only once
- Built-in `EsmaulHusnaListView` and `RandomEsmaulHusnaWidget` widgets
- Null-safe, pure Flutter, no native dependencies

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  esmaulhusna_muslimbg: ^1.0.7
```

Then run:

```bash
flutter pub get
```

---

## Quick start

```dart
import 'package:esmaulhusna_muslimbg/esmaulhusna_muslimbg.dart';

// List all 99 names in English
final names = await EsmaulHusna.getNames('en');
print(names[0]['arabic']);       // الرَّحْمَنُ
print(names[0]['name']);         // The Most Gracious
print(names[0]['translation']);  // The One who has plenty of mercy for all creation

// Get a random name
final random = await EsmaulHusna.getRandomName('tr');
print('${random['arabic']} — ${random['name']}');

// List all supported locale codes
print(EsmaulHusna.getSupportedLanguages());
// [ar, bg, bs_BA, en, sq_AL, tr]
```

---

## Supported locales

| Locale code | Language              | Notes                                         |
|-------------|-----------------------|-----------------------------------------------|
| `ar`        | Arabic                | 99 entries                                    |
| `bg`        | Bulgarian             | 100 entries, fully tested end-to-end          |
| `bs_BA`     | Bosnian               | 100 entries                                   |
| `en`        | English               | 100 entries, used as fallback                 |
| `sq_AL`     | Albanian              | 100 entries                                   |
| `tr`        | Turkish               | 100 entries                                   |

### Accepted locale aliases

The package resolves these inputs to their canonical locale automatically:

| Input                             | Resolves to                          |
|-----------------------------------|--------------------------------------|
| `ar`, `arabic`, `ar_SA`           | `ar`                                 |
| `bg`, `bulgarian`, `bg_BG`        | `bg`                                 |
| `bs`, `bs_BA`, `bosnian`          | `bs_BA`                              |
| `en`, `english`, `en_US`, `en_GB` | `en`                                 |
| `mk`, `mk_MK`, `macedonian`       | `en` (fallback, translation pending) |
| `sq`, `sq_AL`, `sq_XK`, `albanian`| `sq_AL`                              |
| `tr`, `turkish`, `tr_TR`          | `tr`                                 |

Hyphens are normalised to underscores — `bs-BA` and `bs_BA` both work. Unknown locales fall back to `en`.

---

## API reference

### `EsmaulHusna.getNames(String language)`

Returns `Future<List<Map<String, String>>>` with all 99 names for the specified locale.

Results are cached in memory — calling `getNames()` multiple times for the same locale loads assets only once.

```dart
final names = await EsmaulHusna.getNames('bg');

for (final name in names) {
  print(name['arabic']);       // Arabic text
  print(name['name']);         // Localized name
  print(name['translation']);  // Localized meaning
}
```

### `EsmaulHusna.getRandomName(String language)`

Returns `Future<Map<String, String>>` with a randomly selected name.

Throws `StateError` if no data is available for the given locale.

```dart
final name = await EsmaulHusna.getRandomName('en');
print('${name['arabic']} — ${name['name']}');
```

### `EsmaulHusna.getSupportedLanguages()`

Returns an unmodifiable `List<String>` of all canonical locale codes.

```dart
final locales = EsmaulHusna.getSupportedLanguages();
// ['ar', 'bg', 'en', 'tr', 'bs_BA', 'mk_MK', 'sq_AL', 'sq_XK']
```

---

## Response shape

Each map returned by `getNames()` and `getRandomName()` contains:

| Key           | Type     | Example value                          |
|---------------|----------|----------------------------------------|
| `arabic`      | `String` | `الرَّحْمَنُ`                           |
| `name`        | `String` | `The Most Gracious`                    |
| `translation` | `String` | `The One who has plenty of mercy...`   |

---

## Built-in widgets

The package ships two ready-to-use widgets.

### `EsmaulHusnaListView`

Scrollable list of all 99 names:

```dart
import 'package:esmaulhusna_muslimbg/esmaulhusna_muslimbg.dart';

EsmaulHusnaListView(language: 'en')
```

### `RandomEsmaulHusnaWidget`

Card showing a single randomly picked name:

```dart
RandomEsmaulHusnaWidget(language: 'tr')
```

---

## Custom widget example

Build your own UI around the API:

```dart
import 'package:esmaulhusna_muslimbg/esmaulhusna_muslimbg.dart';
import 'package:flutter/material.dart';

class EsmaulHusnaScreen extends StatelessWidget {
  const EsmaulHusnaScreen({super.key, this.language = 'en'});

  final String language;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: EsmaulHusna.getNames(language),
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
            final entry = names[index];
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(entry['name'] ?? ''),
              subtitle: Text(entry['translation'] ?? ''),
              trailing: Text(
                entry['arabic'] ?? '',
                style: const TextStyle(fontSize: 20),
                textDirection: TextDirection.rtl,
              ),
            );
          },
        );
      },
    );
  }
}
```

---

## Integrating with the device locale

The package normalises hyphens and casing, so you can pass the device locale tag directly:

```dart
import 'dart:ui';
import 'package:esmaulhusna_muslimbg/esmaulhusna_muslimbg.dart';

final deviceLocale = PlatformDispatcher.instance.locale;
final names = await EsmaulHusna.getNames(deviceLocale.toLanguageTag());
// 'bs-BA', 'mk-MK', 'sq-AL' all resolve correctly
```

---

## Used in production

This package powers the **MuslimBG** app:

- [Google Play](https://play.google.com/store/apps/details?id=com.boboautomate.muslimbg)
- [App Store](https://apps.apple.com/app/id6467431798)

---

## Migration guide

### 1.0.3 → 1.0.4

The `description` key in name maps has been renamed to `translation`:

```dart
// Before (≤ 1.0.3)
print(name['description']);

// After (1.0.4+)
print(name['translation']);
```

---

## v1.1.0 roadmap

- Typed `EsmaulHusnaName` model instead of raw maps
- `getByIndex(int index, String language)` helper
- Search and filtering helpers
- Grid and detail layout widgets
- Expand and verify dedicated translations for all locales

---

## License

MIT — see [LICENSE](LICENSE)
