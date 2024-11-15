import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ujastore/app/data/models/cart_item_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mendaftar pengguna baru
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error during sign up: $e');
      return null;
    }
  }

  // Login pengguna
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error during sign in: $e');
      return null;
    }
  }

  // Menambahkan item ke keranjang di Firestore menggunakan email sebagai ID
  Future<void> addToCart(String email, CartItem item) async {
    try {
      DocumentReference docRef = _firestore
          .collection('pengguna')
          .doc(email)
          .collection('cartItems')
          .doc(); // Mendapatkan ID otomatis

      await docRef.set(item.toMap());
      print("Item berhasil ditambahkan ke Firestore dengan ID: ${docRef.id}");
    } catch (e) {
      print('Gagal menambahkan item ke keranjang: $e');
    }
  }

  // Mengambil semua item dari keranjang di Firestore menggunakan email sebagai ID
  Future<List<CartItem>> getCartItems(String email) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('pengguna')
          .doc(email)
          .collection('cartItems')
          .get();

      return snapshot.docs.map((doc) {
        return CartItem.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error getting cart items: $e');
      return [];
    }
  }

  // Menghapus item dari keranjang di Firestore menggunakan email sebagai ID
  Future<void> removeFromCart(String email, String itemId) async {
    try {
      await _firestore
          .collection('pengguna')
          .doc(email)
          .collection('cartItems')
          .doc(itemId)
          .delete();
    } catch (e) {
      print('Error removing item from cart: $e');
    }
  }

  // Mengosongkan keranjang di Firestore menggunakan email sebagai ID
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
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }

  // Mendapatkan data pengguna dari Firestore menggunakan email sebagai ID
  Future<Map<String, dynamic>?> getUserData(String email) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('pengguna').doc(email).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  // Memperbarui data pengguna di Firestore menggunakan email sebagai ID
  Future<void> updateUserData(String email, String name, String photoUrl) async {
    try {
      await _firestore.collection('pengguna').doc(email).update({
        'userName': name,
        'profileImagePath': photoUrl,
      });
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  // Menyimpan data pengguna baru ke Firestore menggunakan email sebagai ID
  Future<void> saveUserData(User user, String name, String photoUrl) async {
    try {
      await _firestore.collection('pengguna').doc(user.email).set({
        'userName': name,
        'profileImagePath': photoUrl,
        'email': user.email,
      });
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  // Mendapatkan pengguna yang sedang login
  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  // Logout pengguna
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
