import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  bool isReminderOn = false;

  @override
  void initState() {
    super.initState();
    _loadReminderStatus();
  }

  Future<void> _loadReminderStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isReminderOn = prefs.getBool('reminder') ?? false;
    });
  }

  Future<void> _toggleReminder(bool value) async {
    if (value) {
      _showNotificationPermissionDialog();
    } else {
      _saveReminderStatus(value);
    }
  }

  Future<void> _saveReminderStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isReminderOn = value;
      prefs.setBool('reminder', value);
    });
  }

  void _showNotificationPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Izinkan Notifikasi"),
        content: Text("Aplikasi ingin mengirim pengingat. Izinkan?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _saveReminderStatus(false); // Batalkan
            },
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _saveReminderStatus(true); // Izinkan notifikasi
            },
            child: Text("Izinkan"),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profil"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(245, 227, 227, 1),
                  const Color.fromRGBO(255, 189, 189, 1)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                  backgroundColor: const Color.fromARGB(255, 245, 234, 234),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 5),
                      Text("Edit Foto"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                ListTile(
                  title: Text("Pengaturan Profil"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text("Keamanan Akun"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text("Pengingat"),
                  trailing: Switch(
                    value: isReminderOn,
                    onChanged: _toggleReminder,
                    activeColor: const Color.fromRGBO(255, 189, 189, 1),
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

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controller untuk input field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Fungsi untuk memuat data tersimpan
  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? "";
      _emailController.text = prefs.getString('email') ?? "";
      _phoneController.text = prefs.getString('phone') ?? "";
      _birthDateController.text = prefs.getString('birthDate') ?? "";
      _addressController.text = prefs.getString('address') ?? "";
    });
  }

  // Fungsi untuk menyimpan data profil
  Future<void> _saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('birthDate', _birthDateController.text);
    await prefs.setString('address', _addressController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profil berhasil disimpan")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Pengaturan Profil"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Bagian atas dengan avatar
              Container(
                height: 200, // Tinggi header
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(245, 227, 227, 1),
                      const Color.fromRGBO(255, 189, 189, 1)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
              // Form input
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    Text(
                      "Pengaturan Profil",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildTextField("Nama Lengkap", _nameController),
                    _buildTextField("Email", _emailController),
                    _buildTextField("No Telepon", _phoneController),
                    _buildTextField("Tanggal Lahir", _birthDateController),
                    _buildTextField("Alamat", _addressController, maxLines: 3),
                    SizedBox(height: 50), // Memberi ruang untuk tombol simpan
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(254, 191, 191, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Lonjong
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                        ),
                        child: Text(
                          "Simpan",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Widget untuk membuat TextField dengan border melengkung
  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15), // Melengkung
                borderSide:
                    BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                    BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.pinkAccent),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _confirmSavePassword() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Konfirmasi"),
          content: Text("Apakah Anda yakin ingin mengubah password?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Tutup dialog
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                _savePassword();
              },
              child: Text("Ya"),
            ),
          ],
        ),
      );
    }
  }

  void _savePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password berhasil diperbarui!")),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label tidak boleh kosong";
          }
          if (label == "Konfirmasi Password Baru" &&
              value != _newPasswordController.text) {
            return "Konfirmasi password tidak cocok";
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(bottom: 16, left: 20),
              title:
                  Text("Ubah Password", style: TextStyle(color: Colors.white)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(245, 227, 227, 1),
                      const Color.fromRGBO(255, 189, 189, 1)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildPasswordField(
                        "Password Lama", _oldPasswordController),
                    _buildPasswordField(
                        "Password Baru", _newPasswordController),
                    _buildPasswordField(
                        "Konfirmasi Password Baru", _confirmPasswordController),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: _confirmSavePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(254, 191, 191, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                        ),
                        child: Text(
                          "Ubah Password",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
