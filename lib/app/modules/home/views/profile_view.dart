import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'settings_page.dart'; // Tambahkan import ke SettingsPage

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue[100]!,
              Colors.white
            ], // Gradient background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Bagian profil
              Padding(
                padding: EdgeInsets.all(16),
                child: Card(
                  color: Colors.white, // Warna kartu
                  shadowColor: Colors.black.withOpacity(0.2), // Bayangan kartu
                  elevation: 8, // Efek bayangan
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Membulatkan sudut kartu
                  ),
                  child: Column(
                    children: [
                      Obx(() => ListTile(
                            leading: GestureDetector(
                              child: CircleAvatar(
                                radius: 40, // Ukuran avatar yang lebih besar
                                backgroundImage: controller.profileImage != null
                                    ? FileImage(controller.profileImage!)
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
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            ),
                            title: Obx(() => Text(
                                  controller.userName.value.isNotEmpty
                                      ? controller.userName.value
                                      : 'Nama Pengguna',
                                  style: TextStyle(
                                    color: Colors.blueAccent, // Warna teks nama
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
                      Divider(thickness: 1), // Garis pemisah
                      // Tombol ke SettingsPage
                      ListTile(
                        leading: Icon(Icons.settings,
                            color: Theme.of(context).iconTheme.color),
                        title: Text('Pengaturan',
                            style: TextStyle(
                                color:
                                    Colors.blueAccent, // Warna teks pengaturan
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          Get.to(() => SettingsPage());
                        },
                      ),
                      // Tambahkan tombol Logout
                      ListTile(
                        leading: Icon(Icons.logout, color: Colors.redAccent),
                        title: Text('Logout',
                            style: TextStyle(
                                color: Colors.redAccent, // Warna teks logout
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          controller.logout();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Bagian saldo
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Card(
                  color: Colors.white, // Warna kartu
                  shadowColor: Colors.black.withOpacity(0.2), // Bayangan kartu
                  elevation: 8, // Efek bayangan
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Membulatkan sudut kartu
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Saldo IDR',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueAccent, // Warna teks saldo
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Obx(() => Text(
                              'Rp ${controller.balance.value},-',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.orange),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              // Bagian pesanan
              Padding(
                padding: EdgeInsets.all(16),
                child: Card(
                  color: Colors.white, // Warna kartu
                  shadowColor: Colors.black.withOpacity(0.2), // Bayangan kartu
                  elevation: 8, // Efek bayangan
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Membulatkan sudut kartu
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pesanan Saya',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueAccent, // Warna teks pesanan
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 16),
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
        ),
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
                  color: Colors.blueAccent, // Warna teks label
                  fontSize: 16)), // Ukuran font label
          Text(count.toString(),
              style: TextStyle(
                  color: Colors.grey[700], // Warna teks jumlah
                  fontSize: 16)), // Ukuran font jumlah
        ],
      ),
    );
  }
}
