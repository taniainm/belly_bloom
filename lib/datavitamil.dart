import 'package:flutter/material.dart';

void main() {
  runApp(VitaminApp());
}

class VitaminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VitaminFormPage(),
    );
  }
}

class VitaminFormPage extends StatefulWidget {
  @override
  _VitaminFormPageState createState() => _VitaminFormPageState();
}

class _VitaminFormPageState extends State<VitaminFormPage> {
  String selectedFrequency = "Setiap hari";
  String selectedVitamin = "";
  String selectedForm = "Pil";
  String selectedTime = "Sekali sehari";
  String durationInput = "";
  int selectedPills = 1;
  DateTime selectedStartDate = DateTime.now();

  List<String> forms = ["Pil", "Kapsul", "Tablet", "Sirup", "Injeksi"];
  List<String> frequencies = [
    "Setiap hari",
    "Hari-hari tertentu",
    "Interval hari",
    "Siklus"
  ];
  List<String> times = [
    "Sekali sehari",
    "Dua kali sehari",
    "Tiga kali sehari",
    "Empat kali sehari"
  ];

  final TextStyle labelStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  final double iconSize = 28.0;

  final OutlineInputBorder borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(width: 2, color: Colors.grey),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: iconSize),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Masukkan data",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("vitamin harian anda", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildTextField("Anisa", Icons.person),
            buildVitaminAndFormInput(),
            buildStartDurationFrequencyInput(),
            buildTimeAndPillInput(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simpan data vitamin
              },
              child: Text("TAMBAHKAN"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hint, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, size: iconSize),
          border: borderStyle,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget buildVitaminAndFormInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.local_pharmacy, size: iconSize),
            title: Text("Vitamin:", style: labelStyle),
            subtitle: TextField(
              onChanged: (value) {
                setState(() {
                  selectedVitamin = value;
                });
              },
              decoration: InputDecoration(
                hintText: "",
                border: borderStyle,
              ),
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 12),
          ListTile(
            leading: Icon(Icons.medical_services, size: iconSize),
            title: Text("Bentuk:", style: labelStyle),
            subtitle: DropdownButton<String>(
              value: selectedForm,
              isExpanded: true,
              items: forms.map((form) {
                return DropdownMenuItem(
                  value: form,
                  child: Text(form, style: TextStyle(fontSize: 16)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedForm = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStartDurationFrequencyInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: boxDecoration(),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.calendar_today, size: iconSize),
            title: Text(
              "Tanggal Awal: ${selectedStartDate.toLocal().toString().split(' ')[0]}",
              style: labelStyle,
            ),
            onTap: () {
              _selectStartDate(context);
            },
          ),
          SizedBox(height: 12),
          ListTile(
            leading: Icon(Icons.timer, size: iconSize),
            title: Text("Durasi (dalam hari):", style: labelStyle),
            subtitle: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "",
                border: borderStyle,
              ),
              onChanged: (value) {
                setState(() {
                  durationInput = value;
                });
              },
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 12),
          ListTile(
            leading: Icon(Icons.timeline, size: iconSize),
            title: Text("Rentang Pengonsumsian Obat:", style: labelStyle),
            subtitle: DropdownButton<String>(
              value: selectedFrequency,
              isExpanded: true,
              items: frequencies.map((freq) {
                return DropdownMenuItem(
                  value: freq,
                  child: Text(freq, style: TextStyle(fontSize: 16)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFrequency = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimeAndPillInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: boxDecoration(),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.access_time, size: iconSize),
            title: Text("Waktu:", style: labelStyle),
            subtitle: DropdownButton<String>(
              value: selectedTime,
              isExpanded: true,
              items: times.map((time) {
                return DropdownMenuItem(
                  value: time,
                  child: Text(time, style: TextStyle(fontSize: 16)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTime = value!;
                });
              },
            ),
          ),
          SizedBox(height: 12),
          ListTile(
            leading: Icon(Icons.list, size: iconSize),
            title: Text("Banyak pil:", style: labelStyle),
            subtitle: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: borderStyle),
              onChanged: (value) {
                setState(() {
                  selectedPills = int.tryParse(value) ?? 1;
                });
              },
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(255, 189, 189, 1),
          Color.fromRGBO(245, 227, 227, 1)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }
}
