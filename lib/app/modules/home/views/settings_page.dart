import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/profile_controller.dart';
import 'login_view.dart';
import 'signup_view.dart';

class SettingsPage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final TextEditingController nameController = TextEditingController();

  SettingsPage({Key? key}) : super(key: key) {
    nameController.text = controller.userName.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
        backgroundColor: Colors.grey[900],
        actions: [
          Obx(() => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.userName.value,
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => GestureDetector(
                  onTap: () => _pickImage(controller),
                  child: CircleAvatar(
                    backgroundImage: controller.profileImage != null
                        ? FileImage(controller.profileImage!)
                        : null,
                    radius: 50,
                    child: controller.profileImage == null
                        ? Icon(Icons.camera_alt, size: 50) // Placeholder
                        : null,
                  ),
                )),
            SizedBox(height: 10),
            Obx(() => controller.profileImage != null
                ? ElevatedButton(
                    onPressed: controller.removeProfileImage,
                    child: Text('Hapus Gambar Profil'),
                  )
                : Container()),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama Pengguna'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                controller.setUserName(nameController.text);
                controller.updateUserNameInFirestore(nameController.text);
              },
              child: Text('Simpan Nama'),
            ),
            SizedBox(height: 20),
            Obx(() {
              return SwitchListTile(
                title: Text('Mode Gelap'),
                value: controller.isDarkMode.value,
                onChanged: (value) {
                  controller.toggleTheme(value);
                },
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await controller.logout();
                Get.off(() => LoginView());
              },
              child: Text('Logout'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() => SignUpView());
              },
              child: Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ProfileController controller) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      controller.setImagePath(image.path);
    }
  }
}
