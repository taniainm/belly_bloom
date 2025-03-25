import 'package:flutter/material.dart';

import 'artikel.dart';
import 'momhealth.dart';
import 'profil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PregnancyTracker(),
    );
  }
}

class PregnancyTracker extends StatefulWidget {
  const PregnancyTracker({Key? key}) : super(key: key);
  @override
  _PregnancyTrackerState createState() => _PregnancyTrackerState();
}

class _PregnancyTrackerState extends State<PregnancyTracker> {
  int week = 14;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      // Home
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PregnancyTracker()),
      );
    } else if (index == 1) {
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ArticleScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "img/wp.png",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello,",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(71, 77, 144, 1),
                            ),
                          ),
                          Text(
                            "Anisa Fitria",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(71, 77, 144, 1),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage("img/ava.jpg"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  FruitImageCard(week: week),

                  // Skincare
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 330,
                      margin: EdgeInsets.symmetric(vertical: 15),
                      padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Skincare",
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                    color: Color.fromRGBO(230, 134, 78, 1),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Cari skincaremu di sini!",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(116, 54, 7, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(right: 15, bottom: 5),
                            child: Image.asset(
                              "img/skincare.png",
                              width: 70,
                              height: 80,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Moms Health
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HealthScreen()),
                      );
                    },
                    child: Container(
                      width: 330,
                      margin: EdgeInsets.symmetric(vertical: 15),
                      padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Moms Health",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900,
                                    color: Color.fromRGBO(71, 77, 144, 1),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Monitoring kesehatan",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(123, 62, 173, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(right: 15, bottom: 5),
                            child: Image.asset(
                              "img/health.png",
                              width: 70,
                              height: 80,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // VitaMil
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 330,
                      margin: EdgeInsets.symmetric(vertical: 15),
                      padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "VitaMil",
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                    color: Color.fromRGBO(71, 77, 144, 1),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Reminder konsumsi vitamin",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(123, 62, 173, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(right: 15, bottom: 5),
                            child: Image.asset(
                              "img/vitamin.png",
                              width: 70,
                              height: 80,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Article',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink[300],
        onTap: _onItemTapped,
      ),
    );
  }
}

class FruitImageCard extends StatelessWidget {
  final int week;
  const FruitImageCard({required this.week});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 30),
      width: 330,
      height: 390,
      decoration: BoxDecoration(
        color: Color(0xFFFFF7E6),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 9,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "img/buah.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Minggu $week",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(71, 77, 144, 1),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text("Buka"),
                      SizedBox(width: 5),
                      Icon(Icons.arrow_forward_ios, size: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
