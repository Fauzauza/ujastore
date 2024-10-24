import 'package:get/get.dart';
import '../../../data/services/firebase_service.dart';

class AuthController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  // Metode untuk mendaftar pengguna baru
  Future<bool> signUp(String email, String password) async {
    try {
      final user = await _firebaseService.signUp(email, password);
      return user != null; // Mengembalikan true jika berhasil
    } catch (e) {
      print('SignUp error: $e'); // Log error untuk debugging
      Get.snackbar('Error', e.toString()); // Tampilkan error kepada pengguna
      return false; // Mengembalikan false jika ada error
    }
  }

  // Metode untuk login pengguna
  Future<bool> login(String email, String password) async {
    try {
      final user = await _firebaseService.signIn(email, password);
      return user != null; // Mengembalikan true jika berhasil
    } catch (e) {
      print('Login error: $e'); // Log error untuk debugging
      Get.snackbar('Error', e.toString()); // Tampilkan error kepada pengguna
      return false; // Mengembalikan false jika ada error
    }
  }

  // Metode untuk logout
  Future<void> logout() async {
    await _firebaseService.signOut();
  }

  // Metode untuk memverifikasi kode dua faktor
  Future<bool> verifyCode(String verificationId, String code) async {
    try {
      // Memverifikasi kode dua faktor
      bool isVerified = await _firebaseService.verifyTwoFactorCode(verificationId, code);
      return isVerified; // Mengembalikan true jika verifikasi berhasil
    } catch (e) {
      print('Verification error: $e'); // Log error untuk debugging
      Get.snackbar('Error', e.toString()); // Tampilkan error kepada pengguna
      return false; // Mengembalikan false jika ada error
    }
  }
}
