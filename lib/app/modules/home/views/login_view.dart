import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'signup_view.dart';
import 'settings_page.dart';

class LoginView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await controller.login(emailController.text, passwordController.text);
                if (controller.isLoggedIn.value) {
                  Get.off(() => SettingsPage());
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => Get.to(() => SignUpView()),
              child: Text('Belum punya akun? Daftar di sini.'),
            ),
          ],
        ),
      ),
    );
  }
}
