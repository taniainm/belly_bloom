import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Gambar background penuh layar
          Image.asset(
            'img/informasi.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          // Tombol close di pojok kanan atas
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
                child: Icon(Icons.close, color: Colors.black, size: 20),
              ),
            ),
          ),

          // Container teks di bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(40),
                  margin: const EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0), // agar ada jarak dari badge
                      Text(
                        "Pada fase ini bayi belajar menguap dan menggosok matanya. "
                            "Pertumbuhan rambut-rambut di bayi mulai tumbuh dan otot-otot di wajah bayi terus berkembang.",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ),

                // Tulisan 14 Minggu di luar container
                Positioned(
                  top: -30,
                  right: 20,
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 120),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade500,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "14 Minggu",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
