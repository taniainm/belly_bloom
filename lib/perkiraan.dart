import 'package:flutter/material.dart';

class PerkiraanPage extends StatelessWidget {
  const PerkiraanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(247, 207, 216, 1),
        body: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Atur perkiraan tanggal Persalinanmu ',
                    style: TextStyle(
                        color: Color.fromRGBO(71, 77, 144, 1),
                        fontSize: 34,
                        fontWeight: FontWeight.bold),
                  )),
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(200.0),
                    child: Container(
                        width: constraints.maxWidth * 0.90,
                        height: constraints.maxHeight * 0.70,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 254, 202, 0.9),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Pilih bagaimana Anda ingin memperkirakan tanggal persalinan Anda. ',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(247, 207, 216, 1),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Berdasarkan',
                                      suffixIcon: Icon(Icons.arrow_drop_down),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  Align(
                                    alignment: Alignment.center,
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Berdasarkan',
                                        suffixIcon: Icon(Icons.arrow_drop_down),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      items: <String>[
                                        'Terakhir Haid',
                                        'Ovulasi',
                                        'Pemeriksaan USG'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {},
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle login
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(
                                          247, 207, 216, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      minimumSize: Size(double.infinity,
                                          50), // Full width button
                                    ),
                                    child: Text(
                                      'Lanjutkan',
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              28, 56, 104, 1),
                                          fontSize: 30),
                                    ),
                                  ),
                                ]))),
                  ))
            ],
          );
        }));
  }
}
