import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

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
    final newBP = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BloodPressureInputPage()),
    );

    if (newBP != null && newBP is List<int>) {
      setState(() {
        _bloodPressure = "${newBP[0]}/${newBP[1]} mmHg";
        _addToHistory("Tekanan Darah", "${newBP[0]}/${newBP[1]}");
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

class BloodPressureTrackerScreen extends StatefulWidget {
  const BloodPressureTrackerScreen({super.key});
  @override
  _BloodPressureTrackerScreenState createState() =>
      _BloodPressureTrackerScreenState();
}

class _BloodPressureTrackerScreenState
    extends State<BloodPressureTrackerScreen> {
  int lastSystolic = 0;
  int lastDiastolic = 0;
  List<FlSpot> systolicHistory = [];
  List<FlSpot> diastolicHistory = [];
  List<String> dates = [];

  void _navigateToInputPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BloodPressureInputPage()),
    );

    if (result != null && result is List<int>) {
      setState(() {
        lastSystolic = result[0];
        lastDiastolic = result[1];
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('dd/MM').format(now);
        dates.add(formattedDate);
        systolicHistory.add(
            FlSpot(systolicHistory.length.toDouble(), lastSystolic.toDouble()));
        diastolicHistory.add(FlSpot(
            diastolicHistory.length.toDouble(), lastDiastolic.toDouble()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(title: Text("Pantau Tekanan Darah")),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Tekanan Darah Terakhir:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            lastSystolic > 0 && lastDiastolic > 0
                ? "$lastSystolic/$lastDiastolic mmHg"
                : "Belum ada data",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
          ),
          SizedBox(height: 20),
          Expanded(
            child: dates.isNotEmpty
                ? BloodPressureChart(systolicHistory, diastolicHistory, dates)
                : Center(child: Text("Belum ada riwayat tekanan darah")),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _navigateToInputPage,
            child: Text("Tambah Data Tekanan Darah"),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class WeightTrackerScreen extends StatefulWidget {
  const WeightTrackerScreen({super.key});
  @override
  _WeightTrackerScreenState createState() => _WeightTrackerScreenState();
}

class _WeightTrackerScreenState extends State<WeightTrackerScreen> {
  double currentWeight = 0.0;
  bool isEditing = false;
  TextEditingController _weightController = TextEditingController();
  List<FlSpot> weightHistory = [];
  List<String> weightDates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(title: Text("Masukkan Berat Badan")),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Masukkan Berat Badan",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${currentWeight.toStringAsFixed(1)} Kg",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.edit, color: Colors.black54),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Riwayat",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("Penambahan berat badan"),
          SizedBox(height: 5),
          Expanded(
            child: weightHistory.isNotEmpty
                ? WeightChart(weightHistory, weightDates)
                : Center(child: Text("Belum ada riwayat berat badan")),
          ),
          if (isEditing)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: isEditing ? 250 : 0,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  CalendarHorizontal(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Berat (Kg)",
                        hintText: "Masukkan berat badan",
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_weightController.text.isNotEmpty) {
                        setState(() {
                          currentWeight = double.parse(_weightController.text);
                          isEditing = false;
                          DateTime now = DateTime.now();
                          String formattedDate =
                              DateFormat('dd/MM').format(now);
                          weightDates.add(formattedDate);
                          weightHistory.add(FlSpot(
                              weightHistory.length.toDouble(), currentWeight));
                          Navigator.pop(context, currentWeight.toString());
                        });
                      }
                    },
                    child: Text("Simpan"),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class CalendarHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          DateTime date = now.subtract(Duration(days: 6 - index));
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Text(DateFormat("EEE").format(date)),
                CircleAvatar(
                  backgroundColor:
                      date.day == now.day ? Colors.purple : Colors.transparent,
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WeightChart extends StatelessWidget {
  final List<FlSpot> weightData;
  final List<String> weightDates;
  WeightChart(this.weightData, this.weightDates);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        height: 150,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text("${value.toStringAsFixed(1)} Kg",
                          style: TextStyle(fontSize: 12));
                    }),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= 0 &&
                          value.toInt() < weightDates.length) {
                        return Text(weightDates[value.toInt()],
                            style: TextStyle(fontSize: 12));
                      }
                      return Text("");
                    }),
              ),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: weightData,
                isCurved: true,
                color: Colors.blueAccent,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BloodPressureInputPage extends StatefulWidget {
  @override
  _BloodPressureInputPageState createState() => _BloodPressureInputPageState();
}

class _BloodPressureInputPageState extends State<BloodPressureInputPage> {
  TextEditingController systolicController = TextEditingController();
  TextEditingController diastolicController = TextEditingController();

  void _saveData() {
    if (systolicController.text.isNotEmpty &&
        diastolicController.text.isNotEmpty) {
      int systolic = int.parse(systolicController.text);
      int diastolic = int.parse(diastolicController.text);

      // Kirim data tekanan darah ke layar sebelumnya
      Navigator.pop(context, [systolic, diastolic]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Masukkan Tekanan Darah")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: systolicController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Sistole (atas)"),
            ),
            TextField(
              controller: diastolicController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Diastole (bawah)"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveData, child: Text("Simpan")),
          ],
        ),
      ),
    );
  }
}

class BloodPressureChart extends StatelessWidget {
  final List<FlSpot> systolicData;
  final List<FlSpot> diastolicData;
  final List<String> dates;
  BloodPressureChart(this.systolicData, this.diastolicData, this.dates);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text("${value.toInt()} mmHg",
                        style: TextStyle(fontSize: 12));
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= 0 && value.toInt() < dates.length) {
                      return Text(dates[value.toInt()],
                          style: TextStyle(fontSize: 12));
                    }
                    return Text("");
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: systolicData,
                isCurved: true,
                color: Colors.blueAccent,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: diastolicData,
                isCurved: true,
                color: Colors.redAccent,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
