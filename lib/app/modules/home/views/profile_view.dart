// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'settings_page.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    print(controller.profileImage.runtimeType);
    print(controller.profileImage);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 36, 52),
      appBar: AppBar(
        title: Text(
          "Akun Anda",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 53, 53, 68),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian profil
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              color: Color.fromARGB(255, 40, 36, 52),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius:
                    BorderRadius.circular(10), // Membulatkan sudut kartu
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => ListTile(
                        leading: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 1)),
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
                      )),
                  Divider(
                    thickness: 1,
                    color: Colors.white,
                  ), // Garis pemisah
                  // Tombol ke SettingsPage
                  ListTile(
                    leading: Icon(Icons.settings,
                        color: Theme.of(context).iconTheme.color),
                    title: Text('Pengaturan',
                        style: TextStyle(
                            color: Colors.white, // Warna teks pengaturan
                            fontWeight: FontWeight.bold)),
                    onTap: () {
                      Get.to(() => SettingsPage());
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Pesanan Saya',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Warna teks pesanan
                    fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              color: Color.fromARGB(255, 40, 36, 52),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius:
                    BorderRadius.circular(10), // Membulatkan sudut kartu
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderItem('Belum Bayar', 0, context),
                    _buildOrderItem('Pending', 0, context),
                    _buildOrderItem('Success', 0, context),
                    _buildOrderItem('Expired', 0, context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String label, int count, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: Colors.white, // Warna teks label
                  fontSize: 16)), // Ukuran font label
          Text(count.toString(),
              style: TextStyle(
                  color: Colors.white, // Warna teks jumlah
                  fontSize: 16)), // Ukuran font jumlah
        ],
      ),
    );
  }
}
