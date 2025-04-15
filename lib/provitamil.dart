import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'artikel.dart';
import 'datacatatan.dart';
import 'datavitamil.dart';
import 'utama.dart';

class MedicinePage extends StatefulWidget {
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  final DateTime today = DateTime.now();
  int selectedIndex = 0;
  int _selectedBottomIndex = 0;

  final ScrollController _scrollController = ScrollController();

  final DateTime dateWithData = DateTime(2025, 2, 18);

  // Tambahkan status centang obat
  bool isVitaminETaken = false;
  bool isVitaminCTaken = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(60.0 * 5000);
    });
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PregnancyTracker()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CatatanPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ArticleScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = today.add(Duration(days: selectedIndex));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(300),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF5E3E3), Color(0xFFFFC6C6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header atas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today, color: Colors.black),
                      onPressed: () {
                        // showDatePicker bisa ditaruh di sini
                      },
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('img/ava.jpg'),
                ),
                SizedBox(height: 8),
                Text("Anisa",
                    style:
                        TextStyle(fontSize: 23, fontWeight: FontWeight.w400)),
                SizedBox(height: 4),

                // Tanggal horizontal
                Container(
                  height: 60,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemExtent: 60,
                    itemCount: 10000,
                    itemBuilder: (context, index) {
                      final relativeIndex = index - 5000;
                      final date = today.add(Duration(days: relativeIndex));
                      final isSelected = selectedIndex == relativeIndex;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = relativeIndex;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('dd MMM').format(date),
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  decoration: isSelected
                                      ? TextDecoration.underline
                                      : null,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                DateFormat('E').format(date),
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: isSelected
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Body: daftar obat
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: isSameDay(selectedDate, dateWithData)
              ? [
                  medicineItem("Vitamin E", "09.00", "1 pil", isVitaminETaken,
                      (val) {
                    setState(() {
                      isVitaminETaken = val!;
                    });
                  }),
                  SizedBox(height: 30),
                  medicineItem("Vitamin C", "12.00", "2 pil", isVitaminCTaken,
                      (val) {
                    setState(() {
                      isVitaminCTaken = val!;
                    });
                  }),
                ]
              : [
                  Center(
                    child: Text(
                      "Tidak ada obat pada tanggal ini.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
        ),
      ),

      // Tombol tambah
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 30, bottom: 30),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VitaminFormPage(),
                ),
              );
            },
            backgroundColor: Colors.yellow.shade600,
            child: Icon(Icons.add, color: Colors.black),
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Note'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Article'),
        ],
        currentIndex: _selectedBottomIndex,
        selectedItemColor: Colors.pink[300],
        onTap: _onItemTapped,
      ),
    );
  }

  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  // Item tampilan obat dengan fungsi toggle centang
  Widget medicineItem(String name, String time, String dose, bool taken,
      Function(bool?) onChanged) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Checkbox(value: taken, onChanged: onChanged),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(name, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Text(dose,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
