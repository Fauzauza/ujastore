import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'login_view.dart';

class SignUpView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar'),
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
                await controller.signUp(emailController.text, passwordController.text);
                if (controller.isLoggedIn.value) {
                  Get.off(() => LoginView());
                }
              },
              child: Text('Daftar'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => Get.to(() => LoginView()),
              child: Text('Sudah punya akun? Masuk di sini.'),
            ),
          ],
        ),
      ),
    );
  }
}
