import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'berat.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'BellyBloom',
    home: HealthScreen(),
  ));
}

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});
  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  String _weight = "-- Kg";
  String _bloodPressure = "-- mmHg";
  List<Map<String, String>> _history = [];

  void _updateWeight() async {
    final newWeight = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WeightTrackerScreen()),
    );

    if (newWeight != null) {
      setState(() {
        _weight = "$newWeight Kg";
        _addToHistory("Berat Badan", newWeight); // Simpan ke riwayat
      });
    }
  }

  void _updateBloodPressure() async {
    String? newBP = await _showInputDialog("Masukkan Tekanan Darah", "mmHg");
    if (newBP != null && newBP.isNotEmpty) {
      setState(() {
        _bloodPressure = "$newBP mmHg";
        _addToHistory("Tekanan Darah", newBP);
      });
    }
  }

  void _addToHistory(String type, String value) {
    String date = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

    // Ambil data sebelumnya jika ada
    String lastBP = _history.isNotEmpty ? _history.first["bp"]! : "--";
    String lastWeight = _history.isNotEmpty ? _history.first["weight"]! : "--";

    // Inisialisasi data baru dengan data sebelumnya
    Map<String, String> newRecord = {
      "date": date,
      "bp": lastBP, // Gunakan data sebelumnya jika tidak diubah
      "weight": lastWeight, // Gunakan data sebelumnya jika tidak diubah
    };

    // Simpan data baru yang diinput
    if (type == "Berat Badan") {
      newRecord["weight"] = "$value Kg";
    } else if (type == "Tekanan Darah") {
      newRecord["bp"] = "$value mmHg";
    }

    setState(() {
      _history.insert(0, newRecord);
    });
  }

  Future<String?> _showInputDialog(String title, String unit) async {
    TextEditingController _controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: "Contoh: 70"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, _controller.text),
            child: Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return Stack(children: [
        Positioned.fill(
            child: Opacity(
          opacity: 0.7,
          child: Image.asset("img/wp.png", fit: BoxFit.cover),
        )),
        Padding(
          padding: EdgeInsets.only(
              top: constraints.maxHeight * 0.09, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Moms Health',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  HealthCard(
                    title: "Berat Badan",
                    value: _weight,
                    buttonText: "Tambahkan Berat",
                    icon: Icons.monitor_weight,
                    onTap: _updateWeight,
                  ),
                  SizedBox(width: 10),
                  HealthCard(
                    title: "Tekanan Darah",
                    value: _bloodPressure,
                    buttonText: "Tambahkan Tekanan Darah",
                    icon: Icons.monitor_heart,
                    onTap: _updateBloodPressure,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Detail Riwayat",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text("Tanggal")),
                      DataColumn(label: Text("Tekanan Darah")),
                      DataColumn(label: Text("Berat")),
                    ],
                    rows: _history.map((record) {
                      return DataRow(cells: [
                        DataCell(Text(record['date']!)),
                        DataCell(Text(record['bp'] ?? "--")),
                        DataCell(Text(record['weight'] ?? "--")),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        )
      ]);
    }));
  }
}

class HealthCard extends StatelessWidget {
  final String title;
  final String value;
  final String buttonText;
  final IconData icon;
  final VoidCallback onTap;

  HealthCard({
    required this.title,
    required this.value,
    required this.buttonText,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[100],
                foregroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
