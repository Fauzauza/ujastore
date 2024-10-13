import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/github_controller.dart';

class GitHubRepoInfoPage extends StatelessWidget {
  final GitHubController controller = Get.put(GitHubController());

  @override
  Widget build(BuildContext context) {
    // Mengambil info repositori
    controller.fetchRepoInfo('bagussyahrijal/ujastore');

    return Scaffold(
      appBar: AppBar(
        title: Text('Repository Info'),
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        if (controller.repoInfo.value.id == 0) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.repoInfo.value.name.isEmpty) {
          return Center(child: Text('Repository not found!'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.repoInfo.value.name,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 4),
                Text(
                  'Ujastore adalah aplikasi mobile yang dibangun menggunakan Flutter dan Dart, dirancang untuk memberikan pengalaman berbelanja yang sederhana dan efisien. Proyek ini masih dalam tahap pengembangan dan mengikuti pola arsitektur GetX',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 8),
                Text(
                  'Fitur:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '- Bagian banner promo di halaman utama\n'
                  '- Daftar game dan produk\n'
                  '- UI responsif dengan Flutter\n'
                  '- Manajemen state menggunakan GetX',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Menghapus fungsi WebView
                  },
                  child: Text('View on GitHub'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
                SizedBox(height: 24),
                Text(
                  'Statistics',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                _buildStatTile(
                    title: 'Stars',
                    value: '${controller.repoInfo.value.stargazersCount} ⭐'),
                _buildStatTile(
                    title: 'Forks',
                    value: '${controller.repoInfo.value.forksCount} 🍴'),
                _buildStatTile(
                  title: 'Language',
                  value: controller.repoInfo.value.language?.isNotEmpty == true
                      ? controller.repoInfo.value.language!
                      : 'N/A',
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildStatTile({required String title, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18)),
          Text(value, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
