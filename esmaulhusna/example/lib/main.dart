import 'package:flutter/material.dart';
import 'package:esmaulhusna/esmaulhusna.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Esmaul Husna Example',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Esmaul Husna')),
      body: ListView.builder(
        itemCount: 99,
        itemBuilder: (context, index) {
          final number = index + 1;
          return ListTile(
            title: Text(EsmaulHusna.getEnglishName(number)),
            subtitle: Text(EsmaulHusna.getArabicName(number)),
            trailing: Text(number.toString()),
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text(EsmaulHusna.getEnglishName(number)),
                      content: Text(EsmaulHusna.getDescription(number)),
                    ),
              );
            },
          );
        },
      ),
    );
  }
}
