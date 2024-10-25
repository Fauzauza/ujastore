import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ProfileController extends GetxController {
  var imagePath = ''.obs;
  var balance = 0.obs;
  var userName = ''.obs;
  var email = ''.obs;
  var isLoggedIn = false.obs;
  var isDarkMode = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void setImagePath(String path) async {
    imagePath.value = path;
    File imageFile = File(path);
    String downloadUrl = await uploadImage(imageFile);
    imagePath.value = downloadUrl;
    _saveUserProfile();
  }

  File? get profileImage => imagePath.value.isNotEmpty ? File(imagePath.value) : null;

  void setUserName(String name) {
    userName.value = name;
    _saveUserProfile();
  }

  Future<void> login(String userEmail, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: userEmail, password: password);
      email.value = userEmail;
      isLoggedIn.value = true;
      await loadUserData();
      Get.snackbar('Login', 'Login berhasil untuk $userEmail');
    } catch (e) {
      Get.snackbar('Login', 'Login gagal: ${e.toString()}');
    }
  }

  Future<void> signUp(String userEmail, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: userEmail, password: password);
      email.value = userEmail;
      userName.value = userEmail.split('@')[0];
      isLoggedIn.value = true;
      await _saveUserProfile();
      Get.snackbar('Daftar', 'Pendaftaran berhasil untuk $userEmail');
    } catch (e) {
      Get.snackbar('Daftar', 'Pendaftaran gagal: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    userName.value = '';
    email.value = '';
    imagePath.value = '';
    balance.value = 0;
    isLoggedIn.value = false;
    Get.snackbar('Logout', 'Anda telah keluar.');
  }

  Future<void> _saveUserProfile() async {
    if (email.value.isNotEmpty) {
      try {
        await _firestore.collection('pengguna').doc(email.value).set({
          'userName': userName.value,
          'profileImagePath': imagePath.value,
          'balance': balance.value,
          'email': email.value,
        }, SetOptions(merge: true));
        Get.snackbar('Simpan Profil', 'Profil berhasil disimpan.');
      } catch (e) {
        Get.snackbar('Simpan Profil', 'Gagal menyimpan data: ${e.toString()}');
      }
    }
  }

  Future<void> loadUserData() async {
    if (_auth.currentUser != null) {
      email.value = _auth.currentUser!.email!;
      try {
        DocumentSnapshot userDoc = await _firestore.collection('pengguna').doc(email.value).get();
        if (userDoc.exists) {
          userName.value = userDoc['userName'] ?? email.value.split('@')[0];
          imagePath.value = userDoc['profileImagePath'] ?? '';
          balance.value = (userDoc['balance'] ?? 0) is int ? userDoc['balance'] : 0;
          isLoggedIn.value = true;
        } else {
          Get.snackbar('Data Pengguna', 'Data pengguna tidak ditemukan.');
        }
      } catch (e) {
        Get.snackbar('Load Data', 'Gagal memuat data: ${e.toString()}');
      }
    }
  }

  void removeProfileImage() {
    imagePath.value = '';
    _saveUserProfile();
  }

  void toggleTheme(bool isDark) {
    isDarkMode.value = isDark;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> updateUserNameInFirestore(String name) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('pengguna').doc(user.email!).update({
          'userName': name,
        });
        userName.value = name;
        Get.snackbar('Update Profil', 'Nama pengguna diperbarui.');
      } catch (e) {
        Get.snackbar('Update Profil', 'Gagal memperbarui nama: ${e.toString()}');
      }
    }
  }

  Future<void> updateProfileImageInFirestore(String imagePath) async {
    if (email.value.isNotEmpty) {
      try {
        await _firestore.collection('pengguna').doc(email.value).update({'profileImagePath': imagePath});
        Get.snackbar('Update Profil', 'Gambar profil diperbarui.');
      } catch (e) {
        Get.snackbar('Update Profil', 'Gagal memperbarui gambar: ${e.toString()}');
      }
    }
  }

  Future<String> uploadImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString(); // Generate a unique file name
    Reference ref = _storage.ref().child('profile_images/$fileName');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL(); // Return the download URL
  }
}
