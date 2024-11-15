import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ujastore/app/data/models/cart_item_model.dart';
import 'package:ujastore/app/data/services/firebase_service.dart';

class CartController extends GetxController {
  final FirebaseService firebaseService = FirebaseService();
  var cartItems = <CartItem>[].obs;

  // Memuat data keranjang dari Firestore
  Future<void> loadCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email!;
      cartItems.value = await firebaseService.getCartItems(email);
      print("Loaded cart: ${cartItems.length} items");
    } else {
      print("User is not logged in.");
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

  // Menghapus item dari keranjang
  Future<void> removeFromCart(CartItem item) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email!;
      await firebaseService.removeFromCart(email, item.itemId);
      cartItems.remove(item); // Hapus dari UI lokal
    }
  }

  // Mengosongkan keranjang
  Future<void> clearCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email!;
      await firebaseService.clearCart(email);
      cartItems.clear();
    }
  }
}
