// lib/modules/home/views/cart_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujastore/app/modules/home/controllers/cart_controller.dart';
import 'package:ujastore/app/modules/home/controllers/profile_controller.dart';

class CartView extends GetView<CartController> {
  
 
  final profileC = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang"),
          backgroundColor: const Color.fromARGB(255, 53, 53, 68),
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: Text("Keranjang kosong"),
          );
        }
        return ListView.builder(
          itemCount: controller.cartItems.length,
          itemBuilder: (context, index) {
            final item = controller.cartItems[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.videogame_asset, color: Colors.blueAccent),
                title: Text(
                  item.gameName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Item: ${item.itemName}"),
                    Text("Harga: ${item.price}"),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () {
                    controller.removeFromCart(profileC.email.value,controller.cartItems[index].itemId);
                  },
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Item: ${controller.cartItems.length}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  if (controller.cartItems.isNotEmpty) {
                    controller.clearCart(profileC.email.value);
                    Get.snackbar(
                      "Berhasil",
                      "Semua item berhasil dibeli!",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  } else {
                    Get.snackbar(
                      "Keranjang Kosong",
                      "Tambahkan item terlebih dahulu",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                child: Text("Beli Semua"),
              ),
            ],
          ),
        );
      }),
    );
  }
}
