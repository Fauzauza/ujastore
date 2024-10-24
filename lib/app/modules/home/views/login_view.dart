import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujastore/app/modules/home/controllers/profile_controller.dart';
import 'package:ujastore/app/modules/home/controllers/auth_controller.dart';
import 'package:ujastore/app/modules/home/views/home_view.dart';
import 'package:ujastore/app/modules/home/views/signup_view.dart';

class LoginView extends StatelessWidget {
  final ProfileController profileController = Get.find<ProfileController>();
  final AuthController authController = Get.find<AuthController>();

  // Controllers for input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _login(emailController.text, passwordController.text);
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => SignUpView());
              },
              child: Text('Belum punya akun? Daftar'),
            ),
          ],
        ),
      ),
    );
  }

  void _login(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        bool success = await authController.login(email, password);
        if (success) {
          Get.to(() => HomeView()); // Ganti dengan halaman utama aplikasi Anda
        } else {
          Get.snackbar(
              'Login', 'Login gagal. Periksa email dan password Anda.');
        }
      } catch (e) {
        print('Error: $e'); // Log error untuk debugging
        Get.snackbar(
            'Error', 'Terjadi kesalahan saat login. Silakan coba lagi.');
      }
    } else {
      Get.snackbar('Login', 'Email dan Password tidak boleh kosong');
    }
  }
}
