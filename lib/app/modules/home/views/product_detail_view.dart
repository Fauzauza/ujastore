import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujastore/app/data/models/cart_item_model.dart';
import '../../../data/models/product_model.dart';
import '../controllers/cart_controller.dart';
import 'top_up_options.dart';

class ProductDetailView extends StatefulWidget {
  final Product product;

  ProductDetailView({required this.product});

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final CartController cartController = Get.put(CartController());

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: Colors.lightBlue[100]!,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.product.imageUrl),
              SizedBox(height: 20),
              Text(
                widget.product.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Pilih Top Up:', style: TextStyle(fontSize: 18)),
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
              if (widget.product.name == 'Mobile Legends') ...[
                SizedBox(height: 20),
                Text('ID User:', style: TextStyle(fontSize: 16)),
                TextField(
                  controller: userIdController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan ID User Anda',
                  ),
                ),
                SizedBox(height: 10),
                Text('ID Server:', style: TextStyle(fontSize: 16)),
                TextField(
                  controller: serverIdController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan ID Server Anda',
                  ),
                ),
              ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
