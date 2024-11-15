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
        backgroundColor:
            Colors.blueAccent, // Ganti dengan warna yang lebih cerah
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
      body: Container(
        color: Colors.grey[200], // Latar belakang yang lebih cerah
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                          ? Icon(Icons.camera_alt,
                              size: 50, color: Colors.grey) // Placeholder
                          : null,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                    ),
                  )),
              SizedBox(height: 10),
              Obx(() => controller.profileImage != null
                  ? ElevatedButton(
                      onPressed: controller.removeProfileImage,
                      child: Text('Hapus Gambar Profil'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent, // Warna tombol
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      ),
                    )
                  : Container()),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Pengguna',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white, // Warna latar belakang input
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  controller.setUserName(nameController.text);
                  controller.updateUserNameInFirestore(nameController.text);
                },
                child: Text('Simpan Nama'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent, // Warna tombol
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),
              SizedBox(height: 20),
              Obx(() {
                return SwitchListTile(
                  title: Text('Mode Gelap', style: TextStyle(fontSize: 18)),
                  value: controller.isDarkMode.value,
                  onChanged: (value) {
                    controller.toggleTheme(value);
                  },
                  activeColor: Colors.blueAccent, // Warna aktif switch
                );
              }),
              SizedBox(height: 20),
              Obx(() {
                return ElevatedButton(
                  onPressed: controller.isLoggedIn.value
                      ? null // Nonaktifkan tombol jika sudah login
                      : () async {
                          await controller.logout();
                          Get.off(() => LoginView());
                        },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent, // Warna tombol
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  ),
                );
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => SignUpView());
                },
                child: Text('Daftar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent, // Warna tombol
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),
            ],
          ),
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
