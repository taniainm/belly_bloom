import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: BloodPressureTrackerScreen(),
  ));
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
