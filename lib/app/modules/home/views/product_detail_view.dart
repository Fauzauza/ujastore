import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujastore/app/data/models/cart_item_model.dart';
import '../../../data/models/product_model.dart';
import '../controllers/cart_controller.dart';
import '../controllers/audio_controller.dart'; // Import AudioController
import 'top_up_options.dart';

class ProductDetailView extends StatefulWidget {
  final Product product;

  ProductDetailView({required this.product});

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final CartController cartController = Get.put(CartController());
  final AudioController audioController =
      Get.put(AudioController()); // Inisialisasi AudioController

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController serverIdController = TextEditingController();

  String selectedTitle = '';
  String selectedPrice = '';

  // Fungsi untuk menambahkan item ke keranjang
  void addItemToCart() {
    CartItem item = CartItem(
      itemId: '', // ID akan diisi oleh Firestore nanti
      gameName: widget.product.name,
      itemName: selectedTitle,
      price: selectedPrice,
      userId: userIdController.text, // Ambil dari input pengguna
      serverId: serverIdController.text, // Ambil dari input pengguna
    );

    cartController.addToCart(item);
    Get.snackbar(
      'Berhasil',
      '$selectedTitle berhasil ditambahkan ke keranjang',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Tentukan URL audio untuk produk tertentu
    String audioUrl = widget.product.name == 'Mobile Legends'
        ? 'https://drive.google.com/uc?export=download&id=1qTv2q3d0_np1-P5IZQQBqeovmVlxFn90' // URL untuk Mobile Legends
        : widget.product.name == 'PUBG'
            ? 'https://drive.google.com/uc?export=download&id=1xRwKfn1qCvJA2WRBvnQ3Tr8g9W-0xpCw' // URL untuk PUBG
            : widget.product.name == 'Honor of Kings'
                ? 'https://drive.google.com/uc?export=download&id=157I9lW6Cv5AnhWVJItZJI8IpcmJYs4eV' // URL untuk Honor of Kings
                : widget.product.name == 'Growtopia'
                    ? 'https://drive.google.com/uc?export=download&id=191EjLjrB_8IRzXxhaI2QRZpQQwIQG1eo' // URL untuk Growtopia
                    : widget.product.name == 'Free Fire'
                        ? 'https://drive.google.com/uc?export=download&id=191EjLjrB_8IRzXxhaI2QRZpQQwIQG1eo' // URL untuk Free Fire
                        : widget.product.name == 'LoL: Wild Rift'
                            ? 'https://drive.google.com/uc?export=download&id=1PFv3Q-68j1iokxxkq4yW6N43hqtaRf5Y' // URL untuk LoL: Wild Rift
                            : widget.product.name == 'Valorant'
                                ? 'https://drive.google.com/uc?export=download&id=1E7OdPf2-Aazh__FKccyJwOWskqv4FLC-' // URL untuk Valorant
                                : widget.product.name == 'Genshin Impact'
                                    ? 'https://drive.google.com/uc?export=download&id=1BPLOYZUC4B_F2kIgyUSNSSp2nr2ZKaG6' // URL untuk Genshin Impact
                                    : widget.product.name ==
                                            'Call of Duty Mobile'
                                        ? 'https://drive.google.com/uc?export=download&id=1cSUj2iNiPaaGyn9NQ2CmAX2r5cWqfrlX' // URL untuk Call of Duty Mobile
                                        : widget.product.name ==
                                                'Arena of Valor'
                                            ? 'https://drive.google.com/uc?export=download&id=1fRZbszgdPu5ewC3fIJTA3BeobwjBGUPI' // URL untuk Arena of Valor
                                            : widget.product.name ==
                                                    'Point Blank'
                                                ? 'https://drive.google.com/uc?export=download&id=1VLXyDuUFeW9Zq3bTzLZl550b4NmNAyg1' // URL untuk Point Blank
                                                : widget.product.name ==
                                                        'Ragnarok M: Eternal Love'
                                                    ? 'https://drive.google.com/uc?export=download&id=1IP7FuU9P6TVAEGy9DhJeHPLpcgg8vJYP' // URL untuk Ragnarok M: Eternal Love
                                                    : widget.product.name ==
                                                            'Stumble Guys'
                                                        ? 'https://drive.google.com/uc?export=download&id=1vbRQT4z-AgBVNYApVhZWhh9jgMaMGX81' // URL untuk Stumble Guys
                                                        : '';

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 36, 52),
      appBar: AppBar(
        title: Text(
          widget.product.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 53, 53, 68),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar produk dengan border-radius dan bayangan
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Nama produk dengan teks besar dan berat
              Text(
                widget.product.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(221, 255, 255, 255),
                ),
              ),
              SizedBox(height: 12),

              // Pilihan top-up
              Text(
                'Pilih Top Up:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              TopUpOptions(
                gameName: widget.product.name,
                onSelectItem: (title, price) {
                  setState(() {
                    selectedTitle = title;
                    selectedPrice = price;
                  });
                },
              ),

              // Form ID User dan ID Server dengan input styling
              if (widget.product.name == 'Mobile Legends' ||
                  widget.product.name == 'PUBG' ||
                  widget.product.name == 'Honor of Kings' ||
                  widget.product.name == 'Growtopia' ||
                  widget.product.name == 'Free Fire' ||
                  widget.product.name == 'LoL: Wild Rift' ||
                  widget.product.name == 'Valorant' ||
                  widget.product.name == 'Genshin Impact' ||
                  widget.product.name == 'Call of Duty Mobile' ||
                  widget.product.name == 'Arena of Valor' ||
                  widget.product.name == 'Point Blank' ||
                  widget.product.name == 'Ragnarok M: Eternal Love' ||
                  widget.product.name == 'Stumble Guys') ...[
                SizedBox(height: 20),
                Text('ID User:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                TextField(
                  controller: userIdController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan ID User Anda',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                SizedBox(height: 10),
                Text('ID Server:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                TextField(
                  controller: serverIdController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan ID Server Anda',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                SizedBox(height: 20),

                // Tombol Play dan Stop Audio (menggunakan IconButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.play_arrow,
                          size: 32,
                          color: Colors.green), // Ukuran ikon dikurangi
                      onPressed: () {
                        audioController.playAudio(audioUrl); // Memutar audio
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.stop,
                          size: 32, color: Colors.red), // Ukuran ikon dikurangi
                      onPressed: () {
                        audioController.stopAudio(); // Menghentikan audio
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Obx(() {
                  return Text(
                    audioController.isPlaying.value
                        ? 'Audio is Playing'
                        : 'Audio Stopped',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  );
                }),
              ],

              // Tombol Tambahkan ke Keranjang
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (selectedTitle.isNotEmpty && selectedPrice.isNotEmpty) {
                    addItemToCart();
                  } else {
                    Get.snackbar(
                      'Error',
                      'Pilih item top-up sebelum menambahkan ke keranjang',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                child: Text('Tambahkan ke Keranjang'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
