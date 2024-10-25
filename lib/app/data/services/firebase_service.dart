import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Metode untuk mendaftar pengguna baru
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      // Tangani error jika pendaftaran gagal
      print('Error during sign up: $e');
      return null; // Mengembalikan null jika terjadi kesalahan
    }
  }

  // Metode untuk login pengguna
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      // Tangani error jika login gagal
      print('Error during sign in: $e');
      return null; // Mengembalikan null jika terjadi kesalahan
    }
  }

  // Metode untuk mengambil data pengguna dari Firestore
  Future<Map<String, dynamic>?> getUserData(String email) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('pengguna').doc(email).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?; // Mengembalikan data pengguna
      }
      return null; // Mengembalikan null jika dokumen tidak ditemukan
    } catch (e) {
      print('Error getting user data: $e');
      return null; // Mengembalikan null jika terjadi kesalahan
    }
  }

  // Metode untuk memperbarui data pengguna di Firestore
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

  // Metode untuk mengambil pengguna yang sedang login
  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      print('Error getting current user: $e');
      return null; // Mengembalikan null jika pengguna tidak ditemukan
    }
  }

  // Metode untuk logout pengguna
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // Metode untuk menyimpan data pengguna baru ke Firestore
  Future<void> saveUserData(User user, String name, String photoUrl) async {
  try {
    await _firestore.collection('pengguna').doc(user.uid).set({
      'userName': name,
      'profileImagePath': photoUrl,
      'email': user.email, // Simpan email pengguna
    });
  } catch (e) {
    print('Error saving user data: $e');
  }
}


}
