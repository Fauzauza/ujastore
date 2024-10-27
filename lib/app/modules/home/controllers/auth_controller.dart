import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/firebase_service.dart';

class AuthController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  var userName = ''.obs; // Variabel untuk menyimpan nama pengguna
  var userEmail = ''.obs; // Variabel untuk menyimpan email pengguna

  // Metode untuk mendaftar pengguna baru
  Future<bool> signUp(String email, String password, String name, String photoUrl) async {
    try {
      final user = await _firebaseService.signUp(email, password);
      if (user != null) {
        await _firebaseService.saveUserData(user, name, photoUrl);
        userName.value = name;
        userEmail.value = email;
        await _saveToken(user.uid); // Simpan token saat pendaftaran berhasil
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar('Error', 'Pendaftaran gagal: ${e.toString()}');
      return false;
    }
  }

  // Metode untuk login pengguna
  Future<bool> login(String email, String password) async {
    try {
      final pengguna = await _firebaseService.signIn(email, password);
      if (pengguna != null) {
        await loadUserData(pengguna.uid);
        await _saveToken(pengguna.uid); // Simpan token saat login berhasil
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar('Error', 'Login gagal: ${e.toString()}');
      return false;
    }
  }

  // Metode untuk memuat data pengguna dari Firebase
  Future<void> loadUserData(String userId) async {
    try {
      final userData = await _firebaseService.getUserData(userId);
      if (userData != null) {
        userName.value = userData['userName'] ?? 'Nama tidak tersedia';
        userEmail.value = userData['email'] ?? 'Email tidak tersedia';
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data pengguna: ${e.toString()}');
    }
  }

  // Metode untuk memperbarui data pengguna
  Future<bool> updateUser(String name, String photoUrl) async {
    try {
      final user = await _firebaseService.getCurrentUser();
      if (user != null) {
        await _firebaseService.updateUserData(user.email!, name, photoUrl);
        userName.value = name;
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui data: ${e.toString()}');
      return false;
    }
  }

  // Metode untuk logout
  Future<void> logout() async {
    await _firebaseService.signOut();
    userName.value = '';
    userEmail.value = '';
    await _clearToken(); // Hapus token saat logout
  }

  // Metode untuk menyimpan token di SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token); // Menyimpan token
  }

  // Metode untuk menghapus token dari SharedPreferences
  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken'); // Menghapus token
  }

  // Metode untuk mendapatkan token dari SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken'); // Mengambil token
  }
}
