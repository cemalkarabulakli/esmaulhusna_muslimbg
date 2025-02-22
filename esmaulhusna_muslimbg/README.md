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
import 'package:esmaulhusna_muslimbg/esmaulhusna.dart';

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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
