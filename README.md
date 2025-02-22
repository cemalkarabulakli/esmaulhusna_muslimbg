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
  esmaulhusna_muslimbg: latest_version # Replace with the latest version
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

### Get All Names
```dart 
// Get names in Bulgarian
final bulgarianNames = await EsmaulHusna.getNames('bg');

// Access first name
print(bulgarianNames[0]['name']); // Name in Bulgarian
print(bulgarianNames[0]['arabic']); // Arabic text
print(bulgarianNames[0]['translation']); // Description in Bulgarian
```

### Display Names in a ListView
```dart
 return ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, index) {
              final name = names[index];
              return ListTile(
                title: Text(name['name'] ?? ''),
                subtitle: Text(name['arabic'] ?? ''),
                trailing: Text((index + 1).toString()),
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Center(child: Text(name['name'] ?? '')),
                          content: Text(name['translation'] ?? ''),
                        ),
                  );
                },
              );
            },
          );
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
