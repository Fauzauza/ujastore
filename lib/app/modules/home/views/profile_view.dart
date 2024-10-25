import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'settings_page.dart'; // Tambahkan import ke SettingsPage

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bagian profil
            Padding(
              padding: EdgeInsets.all(16),
              child: Card(
                color: Theme.of(context).cardColor,
                child: Column(
                  children: [
                    Obx(() => ListTile(
                          leading: GestureDetector(
                            child: CircleAvatar(
                              backgroundImage: controller.profileImage != null
                                  ? FileImage(controller.profileImage!)
                                  : null,
                              child: controller.profileImage == null
                                  ? Text(
                                      controller.userName.value.isNotEmpty
                                          ? controller.userName.value[0].toUpperCase()
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
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color),
                              )),
                          subtitle: Obx(() => Text(
                                controller.email.value.isNotEmpty
                                    ? controller.email.value
                                    : 'Email tidak tersedia',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color),
                              )),
                        )),
                    // Tombol ke SettingsPage
                    ListTile(
                      leading: Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
                      title: Text('Pengaturan',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.color)),
                      onTap: () {
                        Get.to(() => SettingsPage());
                      },
                    ),
                    // Tambahkan tombol Logout
                    ListTile(
                      leading: Icon(Icons.logout, color: Theme.of(context).iconTheme.color),
                      title: Text('Logout',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.color)),
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: Theme.of(context).cardColor, // Warna kartu
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Saldo IDR',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color)), // Menggunakan bodyLarge
                            SizedBox(height: 8),
                            Obx(() => Text(
                                  'Rp ${controller.balance.value},-',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.orange),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bagian pesanan
            Padding(
              padding: EdgeInsets.all(16),
              child: Card(
                color: Theme.of(context).cardColor, // Warna kartu
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pesanan Saya',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.color)), // Menggunakan bodyLarge
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
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color)), // Menggunakan bodyLarge
          Text(count.toString(),
              style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color)), // Menggunakan bodyLarge
        ],
      ),
    );
  }
}
