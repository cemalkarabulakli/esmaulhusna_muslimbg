import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:esmaulhusna_muslimbg/esmaulhusna_muslimbg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Esmaul Husna Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _language = 'en';

  static const _localeOptions = [
    ('ar', 'Arabic'),
    ('bg', 'Bulgarian'),
    ('bs_BA', 'Bosnian'),
    ('en', 'English'),
    ('mk_MK', 'Macedonian'),
    ('sq_AL', 'Albanian'),
    ('tr', 'Turkish'),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      _NamesListPage(language: _language),
      _RandomNamePage(language: _language),
      const _LocaleSupportPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Esmaul Husna'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: DropdownButton<String>(
              value: _language,
              underline: const SizedBox.shrink(),
              items:
                  _localeOptions
                      .map(
                        (e) => DropdownMenuItem(value: e.$1, child: Text(e.$2)),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _language = value);
              },
            ),
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected:
            (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list), label: 'Names'),
          NavigationDestination(icon: Icon(Icons.shuffle), label: 'Random'),
          NavigationDestination(icon: Icon(Icons.language), label: 'Locales'),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 1 — Full list with language selector
// ---------------------------------------------------------------------------

class _NamesListPage extends StatefulWidget {
  const _NamesListPage({required this.language});

  final String language;

  @override
  State<_NamesListPage> createState() => _NamesListPageState();
}

class _NamesListPageState extends State<_NamesListPage> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String assetPath) async {
    if (assetPath.isEmpty) return;
    await _player.stop();
    // Load asset bytes and write to a temp file with a safe ASCII filename.
    // This is required for iOS/macOS AVPlayer which needs a valid file URL.
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/audio_${assetPath.hashCode}.mp3');
    if (!file.existsSync()) {
      await file.writeAsBytes(bytes);
    }
    await _player.play(DeviceFileSource(file.path));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: EsmaulHusna.getNames(widget.language),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final names = snapshot.data!;

        return ListView.separated(
          itemCount: names.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, index) {
            final entry = names[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 12,
                  ),
                ),
              ),
              title: Text(entry['name'] ?? ''),
              subtitle: Text(
                entry['translation'] ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                entry['arabic'] ?? '',
                style: const TextStyle(fontSize: 22),
                textDirection: TextDirection.rtl,
              ),
              onTap: () => _showDetail(context, index + 1, entry),
            );
          },
        );
      },
    );
  }

  void _showDetail(
    BuildContext context,
    int number,
    Map<String, String> entry,
  ) {
    final audioPath = entry['audio'] ?? '';
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (_) => Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _playAudio(audioPath),
                  child: Column(
                    children: [
                      Text(
                        entry['arabic'] ?? '',
                        style: const TextStyle(fontSize: 48),
                        textDirection: TextDirection.rtl,
                      ),
                      if (audioPath.isNotEmpty)
                        const Icon(Icons.volume_up, size: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${entry['name']} (#$number)',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  entry['translation'] ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 2 — Random name
// ---------------------------------------------------------------------------

class _RandomNamePage extends StatefulWidget {
  const _RandomNamePage({required this.language});

  final String language;

  @override
  State<_RandomNamePage> createState() => _RandomNamePageState();
}

class _RandomNamePageState extends State<_RandomNamePage> {
  Future<Map<String, String>>? _future;

  void _refresh() {
    final next = EsmaulHusna.getRandomName(widget.language);
    setState(() => _future = next);
  }

  @override
  void initState() {
    super.initState();
    _future = EsmaulHusna.getRandomName(widget.language);
  }

  @override
  void didUpdateWidget(_RandomNamePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.language != widget.language) {
      final next = EsmaulHusna.getRandomName(widget.language);
      setState(() => _future = next);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<Map<String, String>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              final name = snapshot.data!;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Text(
                        name['arabic'] ?? '',
                        style: const TextStyle(fontSize: 52),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        name['name'] ?? '',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        name['translation'] ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: _refresh,
            icon: const Icon(Icons.shuffle),
            label: const Text('New name'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 3 — Supported locales & alias reference
// ---------------------------------------------------------------------------

class _LocaleSupportPage extends StatelessWidget {
  const _LocaleSupportPage();

  @override
  Widget build(BuildContext context) {
    final locales = EsmaulHusna.getSupportedLanguages();

    return Scaffold(
      appBar: AppBar(title: const Text('Supported Locales')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${locales.length} canonical locale codes',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ...locales.map(
            (locale) => ListTile(
              leading: const Icon(Icons.translate),
              title: Text(locale),
              trailing: FutureBuilder<List<Map<String, String>>>(
                future: EsmaulHusna.getNames(locale),
                builder: (_, snap) {
                  if (!snap.hasData) return const SizedBox.shrink();
                  return Text('${snap.data!.length} names');
                },
              ),
            ),
          ),
          const Divider(height: 32),
          Text(
            'Alias examples',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const _AliasRow(input: 'english', resolves: 'en'),
          const _AliasRow(input: 'en_US', resolves: 'en'),
          const _AliasRow(input: 'turkish', resolves: 'tr'),
          const _AliasRow(input: 'bs', resolves: 'bs_BA'),
          const _AliasRow(input: 'bs-BA', resolves: 'bs_BA'),
          const _AliasRow(input: 'mk', resolves: 'mk_MK'),
          const _AliasRow(input: 'sq', resolves: 'sq_AL'),
          const _AliasRow(input: 'unknown', resolves: 'en (fallback)'),
        ],
      ),
    );
  }
}

class _AliasRow extends StatelessWidget {
  const _AliasRow({required this.input, required this.resolves});

  final String input;
  final String resolves;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(input, style: const TextStyle(fontFamily: 'monospace')),
          ),
          const Icon(Icons.arrow_forward, size: 16),
          const SizedBox(width: 8),
          Text(
            resolves,
            style: TextStyle(
              fontFamily: 'monospace',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
