# Esmaul Husna Flutter Package | MuslimBG 

![Esmaul Husna](https://img.shields.io/badge/Esmaul%20Husna-99%20Names-blue)
![Flutter](https://img.shields.io/badge/Flutter-Package-blue)
![Version](https://img.shields.io/badge/version-0.0.5-green)
![Null Safety](https://img.shields.io/badge/null%20safety-enabled-green)

A comprehensive Flutter package providing the **99 Names of Allah (Esmaul Husna)** with translations and meanings in multiple languages. Currently supports **Bulgarian, English, Turkish**. Perfect for Islamic applications, prayer apps, and educational software.

## Features

- Complete list of the 99 Names of Allah with:
  - Original Arabic script
  - Transliterations
  - Translations in multiple languages
  - Detailed meanings and descriptions
- Async API for efficient data loading
- Random name selection functionality
- Comprehensive language support
- Null safety enabled
- Offline support (bundled data)
- Extensive documentation and examples

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  esmaulhusna_muslimbg: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:esmaulhusna_muslimbg/esmaulhusna_muslimbg.dart';
```

### Get Names in Specific Language

```dart
// Get all names in a specific language
final names = await EsmaulHusna.getNames('en');
final bulgarianNames = await EsmaulHusna.getNames('bg');
final turkishNames = await EsmaulHusna.getNames('tr');

// Get a random name
final randomName = await EsmaulHusna.getRandomName('en');
 
```

### Name Structure

Each name entry contains:

```dart
{
  'arabic': 'Arabic text of the name',
  'name': 'Name in requested language',
  'translation': 'Description/meaning in requested language'
}
```

### Example ListView Implementation

```dart
FutureBuilder<List<Map<String, String>>>(
  future: EsmaulHusna.getNames('en'),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final name = snapshot.data![index];
          return ListTile(
            title: Text(name['arabic']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name['name']!),
                Text(name['translation']!),
              ],
            ),
          );
        },
      );
    }
    return CircularProgressIndicator();
  },
)
```

## Supported Languages

- 🇬🇧 English (en)
- 🇧🇬 Bulgarian (bg)
- 🇹🇷 Turkish (tr) 

## Error Handling

The package includes robust error handling:

```dart
try {
  final names = await EsmaulHusna.getNames('invalid_code');
} catch (e) {
  print('Error: Invalid language code');
}
```

## Contributing

Contributions are welcome! Please feel free to submit pull requests, report bugs, or request features on our [GitHub repository](https://github.com/cemalkarabulakli/esmaulhusna_muslimbg).

## License

This package is available under the MIT License.

## Support

If you find this package helpful, please give it a ⭐ on GitHub! 