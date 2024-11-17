import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujastore/app/modules/home/views/home_view.dart';
import '../controllers/profile_controller.dart';
import 'login_view.dart';

class SignUpView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Latar belakang menggunakan gradient
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.lightGreen], // Gradient warna
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
                    'Buat Akun Baru',
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
                  // Tombol Daftar
                  ElevatedButton(
                    onPressed: () async {
                      await controller.signUp(
                          emailController.text, passwordController.text);
                      if (controller.isLoggedIn.value) {
                        Get.off(() => HomeView());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Warna tombol
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Sudut melengkung
                      ),
                    ),
                    child: Text('Daftar', style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: 10),
                  // Tombol Login
                  TextButton(
                    onPressed: () => Get.to(() => LoginView()),
                    child: Text(
                      'Sudah punya akun? Masuk di sini.',
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
