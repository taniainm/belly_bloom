import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'BellyBloom',
    home: HalamanSatu(),
  ));
}

class HalamanSatu extends StatelessWidget {
  const HalamanSatu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 207, 216, 1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: constraints.maxHeight * 0.15, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Hello!',
                        style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(71, 77, 144, 1)),
                      ),
                      Text(
                        'Welcome to',
                        style: TextStyle(
                            fontSize: 34,
                            color: Color.fromRGBO(71, 77, 144, 1)),
                      ),
                      Text(
                        'BellyBloom',
                        style: TextStyle(
                            fontSize: 34,
                            color: Color.fromRGBO(71, 77, 144, 1)),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: constraints.maxHeight * 0.62,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(
                        255, 254, 202, 0.9), // Warna kuning
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50), // Lengkungan di atas kiri
                      topRight: Radius.circular(50), // Lengkungan di atas kanan
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Align(
                          alignment:
                              Alignment.centerLeft, // Posisi teks di kiri
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(247, 207, 216, 1),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Handle forget password
                            },
                            child: Text('Forget password?'),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Handle login
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
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 28, 56, 104)),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () {
                                // Navigate to sign in page
                              },
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 28, 56, 104),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
