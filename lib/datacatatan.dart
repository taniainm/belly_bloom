import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    home: MainPage(),
  ));
}

class IsiCatatan extends StatefulWidget {
  const IsiCatatan({super.key});

  @override
  _IsiCatatanState createState() => _IsiCatatanState();
}

class _IsiCatatanState extends State<IsiCatatan> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();

  List<String> _history = [];
  List<String> _redoHistory = [];
  String _lastText = "";

  void _undo() {
    if (_history.isNotEmpty) {
      setState(() {
        _redoHistory.add(_catatanController.text);
        _catatanController.text = _history.removeLast();
      });
    }
  }

  void _redo() {
    if (_redoHistory.isNotEmpty) {
      setState(() {
        _history.add(_catatanController.text);
        _catatanController.text = _redoHistory.removeLast();
      });
    }
  }

  void _saveCatatan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> current = prefs.getStringList('catatan_baru') ?? [];

    String judul = _judulController.text.trim();
    String isi = _catatanController.text.trim();
    if (judul.isNotEmpty || isi.isNotEmpty) {
      current.add("$judul||$isi");
      await prefs.setStringList('catatan_baru', current);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Catatan disimpan!')),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _judulController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo, color: Colors.black, size: 28),
            onPressed: _undo,
          ),
          IconButton(
            icon: const Icon(Icons.redo, color: Colors.black, size: 28),
            onPressed: _redo,
          ),
          TextButton(
            onPressed: _saveCatatan,
            child: const Text(
              "Selesai",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24, bottom: 24),
              child: TextField(
                controller: _judulController,
                decoration: InputDecoration(
                  hintText: "Judul",
                  filled: true,
                  fillColor: const Color(0xFFFFBDBD),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFBDBD), Color(0xFFF5E3E3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: TextField(
                  controller: _catatanController,
                  onChanged: (text) {
                    if (_lastText != text) {
                      _history.add(_lastText);
                      _lastText = text;
                    }
                  },
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Tulis Catatanmu",
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    const HomePage(),
    const CatatanPage(),
    const ArticlePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Catatan'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Artikel'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink[300],
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Home Page")),
    );
  }
}

class CatatanPage extends StatefulWidget {
  const CatatanPage({super.key});

  @override
  State<CatatanPage> createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  Map<String, List<String>> catatan = {
    "Januari 2025": [
      "Resep sayuran buat bumil",
      "Rekomendasi dokter obgyn sby",
      "Skincare bayi terjangkau",
    ],
    "Oktober 2024": [
      "Olahraga bumil",
      "Nama bayi lucu",
    ],
    "Agustus 2025": [
      "No mual mual",
      "Jadwal check up kandungan",
      "Yang tidak boleh bumil lakukan",
    ],
  };

  List<String> tambahanCatatan = [];

  @override
  void initState() {
    super.initState();
    _loadCatatanBaru();
  }

  Future<void> _loadCatatanBaru() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> saved = prefs.getStringList('catatan_baru') ?? [];

    setState(() {
      tambahanCatatan = saved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Catatan",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  if (tambahanCatatan.isNotEmpty)
                    _buildSection("Catatan Baru", tambahanCatatan),
                  ...catatan.entries.map((entry) {
                    return _buildSection(entry.key, entry.value);
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const IsiCatatan()),
          );
          _loadCatatanBaru();
        },
        backgroundColor: Colors.yellow.shade600,
        child: const Icon(Icons.edit, color: Colors.black),
      ),
    );
  }

  Widget _buildSection(String title, List<String> notes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          children: notes.map((entry) {
            String judul = entry;
            String isi = "";
            if (entry.contains("||")) {
              final split = entry.split("||");
              judul = split[0];
              isi = split.length > 1 ? split[1] : "";
            }

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(title: judul, content: isi)),
                );
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(judul, style: const TextStyle(fontSize: 14)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Artikel Page")),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String content;

  const DetailPage({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Isi catatan dari: $title",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
