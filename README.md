# Esmaul Husna Flutter Package

This repository contains `esmaulhusna_muslimbg`, a Flutter `pub.dev` package for **Esmaul Husna**, **Asma ul Husna**, and the **99 Names of Allah**. It is intended for Islamic mobile apps, Quran readers, dua apps, prayer apps, and Flutter projects that need offline Arabic names plus localized meanings.

Published package: [esmaulhusna_muslimbg on pub.dev](https://pub.dev/packages/esmaulhusna_muslimbg)

## What this repository provides

- Offline Esmaul Husna dataset for Flutter
- Arabic text plus translated name and meaning fields
- Locale code support for `bg`, `en`, `tr`, `bs_BA`, `mk_MK`, `sq_AL`, and `sq_XK`
- Short alias support for `bs`, `mk`, and `sq`
- Example Flutter app under `esmaulhusna_muslimbg/example`

## Supported locale files

Native dataset files:

- `ar`
- `bg`
- `en`

Locale compatibility files:

- `tr`
- `bs_BA`
- `mk_MK`
- `sq_AL`
- `sq_XK`

Compatibility note:
`tr`, `bs_BA`, `mk_MK`, `sq_AL`, and `sq_XK` currently ship with English Esmaul Husna content so apps can support these locale codes right now. Dedicated translations are part of the `v1.1.0` roadmap.

## Installation

```yaml
dependencies:
  esmaulhusna_muslimbg: ^1.0.3
```

## Usage

```dart
import 'package:esmaulhusna_muslimbg/esmaulhusna_muslimbg.dart';

final supported = EsmaulHusna.getSupportedLanguages();
final names = await EsmaulHusna.getNames('bs_BA');
final randomName = await EsmaulHusna.getRandomName('bg');
```

## MuslimBG reference

This package is used in production by the **MuslimBG** app.

- Android: [Google Play](https://play.google.com/store/apps/details?id=com.boboautomate.muslimbg&hl=en&gl=US)
- iOS: [App Store](https://apps.apple.com/app/id6467431798)

## v1.1.0 roadmap

- Finalize locale support for Balkan language codes and Turkish
- Add typed models and cleaner API ergonomics
- Add index-based lookup and search helpers
- Ship dedicated Bosnian, Macedonian, Albanian, and Turkish content
- Expand tests, asset validation, and CI quality checks
- Refresh example app and widget exports

## Repository structure

- Package: `esmaulhusna_muslimbg/`
- Example app: `esmaulhusna_muslimbg/example/`

## SEO keywords

Flutter package for Esmaul Husna, Asma ul Husna, 99 Names of Allah, Islamic app development, Quran app Flutter package, and Balkan Flutter localization.

## License

MIT
