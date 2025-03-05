import 'package:belly_bloom/perkiraan.dart';
import 'package:flutter/material.dart';

class BiodataPage extends StatelessWidget {
  const BiodataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 207, 216, 1),
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 120, left: 20),
              child: Text(
                'Tentang Anda',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(71, 77, 144, 1),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: constraints.maxHeight * 0.60,
                width: constraints.maxWidth * 0.90,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 254, 202, 0.9),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Align(
                        alignment: Alignment.center,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Nama',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Align(
                        alignment: Alignment.center,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Usia',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Align(
                        alignment: Alignment.center,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Apakah anda sedang hamil?',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: <String>['Ya', 'Tidak'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            // Handle change
                          },
                        ),
                      ),
                      SizedBox(height: 120),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PerkiraanPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(247, 207, 216, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          minimumSize:
                              Size(double.infinity, 40), // Full width button
                        ),
                        child: Text(
                          'Lanjutkan',
                          style: TextStyle(
                              color: const Color.fromRGBO(28, 56, 104, 1),
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]);
      }),
    );
  }
}
