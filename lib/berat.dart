import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: WeightTrackerScreen(),
  ));
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
