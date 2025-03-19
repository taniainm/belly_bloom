import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Header: Nama & Foto Profil
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hello,\nAnisa Fitria",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                      "assets/profile.png"), // Ganti dengan gambar profil
                ),
              ],
            ),

            SizedBox(height: 16),

            // 🔹 Container Stateful (Buah)
            Center(child: FruitContainer()),

            SizedBox(height: 16),

            // 🔹 Kartu Info Kehamilan
            InfoCard(
              title: "Usia kehamilan 14 minggu,\nsi kecil makin aktif !",
              subtitle: "Trimester Kedua",
              iconPath: "assets/icons/footprints.png",
              backgroundColor: Colors.white,
            ),

            SizedBox(height: 16),

            // Kartu Skincare
            InfoCard(
              title: "Skincare",
              subtitle: "Cari skincaremu di sini !",
              iconPath: "assets/icons/skincare.png",
              backgroundColor: Colors.orange[100]!,
              titleColor: Colors.orange,
            ),

            SizedBox(height: 16),

            // 🔹 Dua Kotak di Bawah
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FeatureCard(
                  title: "VitaMil",
                  subtitle: "Reminder minum vitamin",
                  iconPath: "assets/icons/pill.png",
                ),
                FeatureCard(
                  title: "Moms Health",
                  subtitle: "Monitoring kesehatan",
                  iconPath: "assets/icons/health.png",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Stateful Widget untuk Container Buah
class FruitContainer extends StatefulWidget {
  const FruitContainer({super.key});

  @override
  _FruitContainerState createState() => _FruitContainerState();
}

class _FruitContainerState extends State<FruitContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/fruit.png",
              width: 80), // Ganti dengan gambar buah
          SizedBox(height: 8),
          Text(
            "Minggu 14",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: Text("Buka"),
          ),
        ],
      ),
    );
  }
}

// 🔹 Widget untuk Kartu Informasi
class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;
  final Color backgroundColor;
  final Color? titleColor;

  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.backgroundColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: titleColor ?? Colors.purple,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          Image.asset(iconPath, width: 40),
        ],
      ),
    );
  }
}

// 🔹 Widget untuk Kotak Fitur (VitaMil & Moms Health)
class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;

  const FeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Image.asset(iconPath, width: 40),
        ],
      ),
    );
  }
}
