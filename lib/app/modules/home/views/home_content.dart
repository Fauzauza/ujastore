import 'package:flutter/material.dart';
import 'package:ujastore/app/modules/home/widgets/promo_banner_slider.dart'; // Pastikan untuk mengimpor kelas yang benar
import '../widgets/product_grid.dart';

// Widget untuk halaman Home (termasuk PromoBannerSlider dan ProductGrid)
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Daftar banner yang ingin ditampilkan
    final List<String> bannerTexts = [
      'Diskon 50% untuk semua produk!',
      'Dapatkan gratis ongkir untuk pembelian di atas Rp 200.000!',
      'Ikuti kami di media sosial untuk update promo terbaru!',
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Column(
          children: [
            const SizedBox(height: 10),
            PromoBannerSlider(
                banners: bannerTexts), // Menggunakan PromoBannerSlider di sini
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'List Game',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ProductGrid(), // Menampilkan grid produk
          ],
        ),
      ),
    );
  }
}
