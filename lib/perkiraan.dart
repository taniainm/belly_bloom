import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:belly_bloom/utama.dart';

class PerkiraanPage extends StatefulWidget {
  const PerkiraanPage({super.key});

  @override
  State<PerkiraanPage> createState() => _PerkiraanPageState();
}

class _PerkiraanPageState extends State<PerkiraanPage> {
  String? _selectedMethod;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _simpanDataKehamilan() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User belum login");

      if (_selectedMethod == null) {
        throw Exception("Pilih metode perkiraan terlebih dahulu");
      }

      final firestore = FirebaseFirestore.instance;

      // Simpan ke document user yang sudah ada (bukan membuat baru)
      await firestore.collection('users').doc(user.uid).set({
        'metode_perkiraan': _selectedMethod,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PregnancyTracker()),
        );
      }
    } on FirebaseException catch (e) {
      setState(() {
        _errorMessage = 'Error Firebase: ${e.message ?? e.code}';
      });
      print("Firestore error: ${e.code} - ${e.message}");
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal menyimpan data: ${e.toString()}';
      });
      print("Error: $e");
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
                            color: Color.fromRGBO(71, 77, 144, 1),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        value: _selectedMethod,
                        decoration: InputDecoration(
                          labelText: 'Berdasarkan',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: [
                          'Hari Pertama Haid (HPHT)',
                          'Tanggal Ovulasi',
                          'Pemeriksaan USG'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedMethod = newValue;
                          });
                        },
                      ),
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: (_selectedMethod == null || _isLoading)
                            ? null
                            : _simpanDataKehamilan,
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
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
