import 'package:flutter/material.dart';
import 'package:belly_bloom/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'BellyBloom',
    home: LandingPage(),
    routes: <String, WidgetBuilder>{
      '/login': (BuildContext context) => HalamanSatu()
    },
  ));
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "img/background.png",
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "img/LogoBellyBloom.png",
                        width: 300,
                        height: 300,
                      ),
                      SizedBox(height: 100),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(247, 207, 216, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          minimumSize:
                              Size(double.infinity, 50), // Full width button
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Pusatkan elemen dalam Row
                          children: [
                            Text(
                              'Start',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 28, 56, 104),
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(width: 20), // Jarak antara teks dan ikon
                            Icon(
                              Icons.arrow_forward,
                              color: const Color.fromARGB(255, 28, 56, 104),
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
