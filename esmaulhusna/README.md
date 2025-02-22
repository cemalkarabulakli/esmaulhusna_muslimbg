# Esmaul Husna Flutter Package | MuslimBG 

![Esmaul Husna](https://img.shields.io/badge/Esmaul%20Husna-99%20Names-blue)
![Flutter](https://img.shields.io/badge/Flutter-Package-blue)

A Flutter package that provides the **99 Names of Allah (Esmaul Husna)** with their meanings and descriptions in **Bulgarian, English, and Turkish**. This package helps developers integrate Esmaul Husna into their Flutter applications easily. Ideal for Islamic apps like Quran apps, and other religious applications.

## Features
- List of **99 Names of Allah** with Arabic script, transliteration, and meanings in **Bulgarian, English, and Turkish**.
- Ability to fetch a random name.
- Offline support (data is bundled with the package).
- Simple and lightweight.
- Perfect for Islamic apps, Quran study apps, and prayer apps.

## Installation
Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  esmaulhusna: latest_version # Replace with the latest version
```

Then run:

```sh
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:esmaulhusna/esmaulhusna.dart';
```

### Get a Specific Name by Number
```dart
int number = 1; // Replace with any number between 1-99
print("English: ${EsmaulHusna.getEnglishName(number)}");
print("Arabic: ${EsmaulHusna.getArabicName(number)}");
print("Turkish: ${EsmaulHusna.getTurkishName(number)}");
print("Bulgarian: ${EsmaulHusna.getBulgarianName(number)}");
print("Description: ${EsmaulHusna.getDescription(number)}");
```

### Get All Names
```dart
List<String> englishNames = EsmaulHusna.getAllEnglishNames();
List<String> arabicNames = EsmaulHusna.getAllArabicNames();
List<String> turkishNames = EsmaulHusna.getAllTurkishNames();
List<String> bulgarianNames = EsmaulHusna.getAllBulgarianNames();
```

### Display Names in a ListView
```dart
ListView.builder(
  itemCount: EsmaulHusna.getAllEnglishNames().length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(EsmaulHusna.getArabicName(index + 1), style: TextStyle(fontSize: 20)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("English: ${EsmaulHusna.getEnglishName(index + 1)}"),
          Text("Turkish: ${EsmaulHusna.getTurkishName(index + 1)}"),
          Text("Bulgarian: ${EsmaulHusna.getBulgarianName(index + 1)}"),
          Text("Description: ${EsmaulHusna.getDescription(index + 1)}"),
        ],
      ),
    );
  },
)
```

## Example App
Check the `example/` directory for a complete working app that demonstrates how to use the package.

## Repository
The source code for this package is available on GitHub: [cemalkarabulakli/esmaulhusna](https://github.com/cemalkarabulakli/esmaulhusna)

## Contributing
Contributions are welcome! Feel free to submit a pull request or open an issue for feature requests and bug reports.

## License
This package is released under the **MIT License**.

## Support
If you find this package useful, consider giving it a ⭐ on GitHub!

This package is perfect for developing **Islamic apps**, **Quran**, and other prayer-related applications.
