import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:belly_bloom/perkiraan.dart';

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _usiaController = TextEditingController();
  String? _kehamilan;

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _simpanKeFirestore() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Validasi input
      if (_namaController.text.isEmpty) {
        throw Exception("Nama tidak boleh kosong");
      }

      if (_usiaController.text.isEmpty) {
        throw Exception("Usia tidak boleh kosong");
      }

      if (_kehamilan == null) {
        throw Exception("Pilih status kehamilan");
      }

      // Parse usia ke integer
      final usia = int.tryParse(_usiaController.text);
      if (usia == null || usia <= 0) {
        throw Exception("Usia harus berupa angka positif");
      }

      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("Anda harus login terlebih dahulu");
      }

      // Simpan ke Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'nama': _namaController.text.trim(),
        'usia': usia,
        'kehamilan': _kehamilan!,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Navigasi setelah berhasil disimpan
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PerkiraanPage()),
        );
      }
    } on FirebaseException catch (e) {
      setState(() {
        _errorMessage = 'Error Firebase: ${e.message ?? e.code}';
      });
      print("Firestore error: ${e.code} - ${e.message}");
    } on FormatException catch (e) {
      setState(() {
        _errorMessage = 'Format usia tidak valid';
      });
      print("Format error: $e");
    } on Exception catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      print("General error: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(children: [
          Positioned.fill(
            child: Image.asset(
              "img/background.png",
              fit: BoxFit.cover,
            ),
          ),
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
                  color: const Color.fromRGBO(255, 255, 242, 0.72),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      TextField(
                        controller: _namaController,
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
                      SizedBox(height: 20),
                      TextField(
                        controller: _usiaController,
                        keyboardType: TextInputType.number,
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
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _kehamilan,
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
                          setState(() {
                            _kehamilan = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 30),
                      if (_errorMessage != null)
                        Text(_errorMessage!,
                            style: TextStyle(color: Colors.red)),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _simpanKeFirestore,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(247, 207, 216, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          minimumSize: Size(double.infinity, 40),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: Color.fromRGBO(71, 77, 144, 1),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Lanjutkan',
                                  style: TextStyle(
                                      color: Color.fromRGBO(71, 77, 144, 1),
                                      fontSize: 20),
                                ),
                              ),
                      ),
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
