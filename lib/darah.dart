import 'package:flutter/material.dart';

class BloodPressureInputScreen extends StatefulWidget {
  const BloodPressureInputScreen({super.key});
  @override
  _BloodPressureInputScreenState createState() =>
      _BloodPressureInputScreenState();
}

class _BloodPressureInputScreenState extends State<BloodPressureInputScreen> {
  TextEditingController _bpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Masukkan Tekanan Darah")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _bpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tekanan Darah (mmHg)",
                hintText: "Contoh: 120/80",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String bp = _bpController.text;
                if (bp.isNotEmpty) {
                  Navigator.pop(context, bp); // Kembali dengan nilai BP
                }
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
