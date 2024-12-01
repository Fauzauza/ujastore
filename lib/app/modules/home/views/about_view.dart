// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Kami'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Sejarah UjaStore
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Sejarah UjaStore',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '''Seorang pengusaha muda memiliki passion dalam dunia gaming dan melihat banyak pemain game kesulitan dalam melakukan top up atau pembelian item game. Oleh karena itu, ia memutuskan untuk memulai bisnis baru yang dikenal sebagai UjaStore pada tahun 2024. 
                        
UjaStore adalah sebuah website yang menyediakan layanan top up game bagi pemain game dengan fitur unik seperti sistem pembayaran yang aman, proses top up yang cepat, dan layanan pelanggan yang responsif.
''',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 20),

            // Visi dan Misi
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Visi dan Misi',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.visibility, size: 30),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Visi: Menjadi layanan top up game terkemuka dan terpercaya bagi pemain game di seluruh dunia.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.assignment, size: 30),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Misi: Memberikan layanan top up game yang cepat, mudah, dan aman bagi pemain game dengan layanan pelanggan yang responsif dan memuaskan.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            // Lokasi Pengguna
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Koordinat Lokasi Pengguna:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() => Text(controller.locationMessage.value)),
            const SizedBox(height: 20),
            controller.loading.value
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: controller.getCurrentLocation,
                    child: const Text('Cari Lokasi'),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.openGoogleMaps,
              child: const Text('Buka Google Maps'),
            ),

            // Kantor Pusat
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Kantor Pusat UjaStore',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Alamat: Gg. 12 No.3, Dusun Bend., Landungsari, Kec. Dau, Kabupaten Malang, Jawa Timur 65151',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
