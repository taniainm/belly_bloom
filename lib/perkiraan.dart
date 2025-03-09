import 'package:flutter/material.dart';

class PerkiraanPage extends StatelessWidget {
  const PerkiraanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "img/background.png",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 30),
                child: Text(
                  'Atur Perkiraan Tanggal Persalinan',
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
                child: Container(
                  height: constraints.maxHeight * 0.55,
                  width: constraints.maxWidth * 0.90,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 242, 0.72),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                                'Pilih bagaimana Anda ingin memperkirakan tanggal persalinan Anda',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: const Color.fromRGBO(71, 77, 144, 1),
                                )),
                          ),
                          SizedBox(height: 15),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Berdasarkan',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                items: <String>[
                                  'Hari Pertama Haid (HPHT)',
                                  'Tanggal Ovulasi',
                                  'Pemeriksaan USG'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {},
                              ),
                            ),
                          ),
                          SizedBox(height: 220),
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
                              minimumSize: Size(double.infinity, 40),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Lanjutkan',
                                style: TextStyle(
                                    color: const Color.fromRGBO(71, 77, 144, 1),
                                    fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      )),
                ))
          ],
        );
      }),
    );
  }
}
