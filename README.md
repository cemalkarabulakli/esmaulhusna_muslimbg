# Esmaul Husna - 99 Names of Allah | MuslimBG

A Flutter package providing access to the 99 Names of Allah (Esmaul Husna) in multiple languages with descriptions and meanings.

## Features

- 📚 Support for multiple languages:
  - English
  - Turkish
  - Bulgarian
- 🔍 Detailed descriptions and meanings
- ⚡ Async loading for better performance
- 🛡️ Type-safe API
- 🌐 Proper Unicode support for Arabic text

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  esmaulhusna_muslimbg: latest_version
```

## Usage

### Basic Usage

```dart
import 'package:esmaulhusna_muslimbg/esmaulhusna_muslimbg.dart';

// Get names in English
final englishNames = await EsmaulHusna.getNames('bg');

// Access first name (Al-Rahman)
print(englishNames[0]['name']);       // The Most Gracious
print(englishNames[0]['arabic']);     // الرَّحْمَنُ
print(englishNames[0]['translation']); // The description/meaning
```

### Available Languages

```dart
// Get names in different languages
final arabicNames = await EsmaulHusna.getNames('bg');
final turkishNames = await EsmaulHusna.getNames('tr');
final bulgarianNames = await EsmaulHusna.getNames('en');
```

```dart
// Get a random name in Bulgarian. This can be used for daily notification or random name.
final randomName = await EsmaulHusna.getRandomName('bg');
print(randomName['name']); // Name in Bulgarian
print(randomName['arabic']); // Arabic text of the name
print(randomName['translation']); // Description/meaning in Bulgarian
```

### Response Format

Each name in the returned list contains:

```dart
{
  'arabic': 'Arabic text of the name',
  'name': 'Name in requested language',
  'translation': 'Description/meaning in requested language'
}
```

## Error Handling

The package includes proper error handling:

```dart
try {
  final names = await EsmaulHusna.getNames('bg');
  // Use the names...
} catch (e) {
  print('Error loading names: $e');
}
```

## Example

A complete example showing how to display the names in a ListView:

```dart
class NamesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: EsmaulHusna.getNames('bg'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final name = snapshot.data![index];
              return ListTile(
                title: Text(name['name']!),
                subtitle: Text(name['translation']!),
                leading: Text(name['arabic']!),
              );
            },
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
```

## Example App
Check the `example/` directory for a complete working app that demonstrates how to use the package.

## Repository
The source code for this package is available on GitHub: [cemalkarabulakli/esmaulhusna_muslimbg](https://github.com/cemalkarabulakli/esmaulhusna_muslimbg)

## Contributing
Contributions are welcome! Feel free to submit a pull request or open an issue for feature requests and bug reports.

## License
This package is released under the **MIT License**.

## Support
If you find this package useful, consider giving it a ⭐ on GitHub!

This package is perfect for developing **Islamic apps**, **Quran**, and other prayer-related applications.
