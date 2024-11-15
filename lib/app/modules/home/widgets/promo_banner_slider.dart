import 'package:flutter/material.dart';
import 'package:ujastore/app/modules/home/widgets/promo_banner.dart';

class PromoBannerSlider extends StatelessWidget {
  final List<String> banners; // Daftar teks untuk banner

  const PromoBannerSlider({Key? key, required this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Tinggi banner
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          return PromoBanner(
              text:
                  banners[index]); // Menggunakan PromoBanner untuk setiap teks
        },
      ),
    );
  }
}
