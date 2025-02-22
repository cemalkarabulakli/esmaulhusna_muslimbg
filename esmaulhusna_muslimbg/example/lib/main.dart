import 'package:esmaulhusna_muslimbg/esmaulhusna.dart';
import 'package:flutter/material.dart';

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
      body: FutureBuilder<List<Map<String, String>>>(
        future: EsmaulHusna.getNames('bg'),
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
        },
      ),
    );
  }
}
