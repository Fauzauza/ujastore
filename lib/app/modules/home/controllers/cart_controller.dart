// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ujastore/app/data/models/cart_item_model.dart';
import 'package:ujastore/app/data/services/firebase_service.dart';

class CartController extends GetxController {
  final FirebaseService firebaseService = FirebaseService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // Jika akun berubah, reload cart
        reloadCart();
      } else {
        cartItems.clear();
        print("User logged out.");
      }
    });
  }

  Future<void> reloadCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email!;
      cartItems.value = await firebaseService.getCartItems(email);
      print("Reloaded cart: ${cartItems.length} items for $email");
    } else {
      print("No user logged in.");
    }
  }

  // Menambahkan item ke keranjang
  Future<void> addToCart(CartItem item) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email!;
      await firebaseService.addToCart(email, item);
      cartItems.add(item); // Perbarui UI lokal setelah berhasil
    }
  }

  Future<void> removeFromCart(String email, String itemId) async {
    try {
      await _firestore
          .collection('pengguna')
          .doc(email)
          .collection('cartItems')
          .doc(itemId)
          .delete();
      print('keapus');
      cartItems.removeWhere((item) => item.itemId == itemId);
    } catch (e) {
      print('Error removing item from cart: $e');
    }
  }

  // Mengosongkan keranjang
  Future<void> clearCart(String email) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('pengguna')
          .doc(email)
          .collection('cartItems')
          .get();
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
      cartItems.clear();
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }

  @override
  void dispose() {
    cartItems.close();
    super.dispose();
  }
}
