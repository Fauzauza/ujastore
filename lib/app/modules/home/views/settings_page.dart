import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/profile_controller.dart';

class SettingsPage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final TextEditingController nameController = TextEditingController();

  SettingsPage({super.key}) {
    nameController.text = controller.userName.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 36, 52),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 53, 53, 68),
        title: Text('Pengaturan'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                color: Color.fromARGB(255, 40, 36, 52),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => ListTile(
                          leading: GestureDetector(
                            onTap: () => _pickImage(controller),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 1)),
                              child: CircleAvatar(
                                radius: 30, // Ukuran avatar yang lebih besar
                                backgroundImage: controller
                                        .imagePath.value.isNotEmpty
                                    ? NetworkImage(controller.imagePath
                                        .value) // Gunakan langsung sebagai URL
                                    : null,
                                child: controller.profileImage == null
                                    ? Text(
                                        controller.userName.value.isNotEmpty
                                            ? controller.userName.value[0]
                                                .toUpperCase()
                                            : 'U',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          title: Obx(() => Text(
                                controller.userName.value.isNotEmpty
                                    ? controller.userName.value
                                    : 'Nama Pengguna',
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                      255, 255, 255, 255), // Warna teks nama
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20, // Ukuran font lebih besar
                                ),
                              )),
                          subtitle: Obx(() => Text(
                                controller.email.value.isNotEmpty
                                    ? controller.email.value
                                    : 'Email tidak tersedia',
                                style: TextStyle(
                                  color: Colors.grey[600], // Warna teks email
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Color.fromARGB(255, 40, 36, 52),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        "Email",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: controller.email.value,
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white, // Warna latar belakang input
                        ),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama Pengguna",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white, // Warna latar belakang input
                              ),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.setUserName(nameController.text);
                            controller
                                .updateUserNameInFirestore(nameController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent, // Warna tombol
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                          ),
                          child: Text('Simpan Perubahan', style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
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
