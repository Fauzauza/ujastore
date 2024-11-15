import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujastore/app/modules/home/views/home_view.dart';
import '../controllers/profile_controller.dart';
import 'signup_view.dart';

class LoginView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menambahkan AppBar dengan tombol back
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Aksi untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      // Latar belakang menggunakan gradient
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue], // Gradient warna
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Judul dengan gaya yang menarik
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Logo Aplikasi
                  Image.asset(
                    'assets/logo.png', // Path gambar logo
                    width: 100, // Lebar logo
                    height: 100, // Tinggi logo
                  ),
                  SizedBox(height: 40),
                  // Input Email
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Input Password
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Tombol Login
                  Obx(() {
                    return ElevatedButton(
                      onPressed: controller.isLoggedIn.value
                          ? null
                          : () async {
                              await controller.login(emailController.text,
                                  passwordController.text);
                              if (controller.isLoggedIn.value) {
                                Get.off(() => HomeView());
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Warna tombol
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Sudut melengkung
                        ),
                      ),
                      child: Text('Login', style: TextStyle(fontSize: 18)),
                    );
                  }),
                  SizedBox(height: 10),
                  // Tombol Daftar
                  TextButton(
                    onPressed: () => Get.to(() => SignUpView()),
                    child: Text(
                      'Belum punya akun? Daftar di sini.',
                      style: TextStyle(color: Colors.white), // Warna teks
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
