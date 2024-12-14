import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';

import 'package:ujastore/app/modules/home/views/home_view.dart';

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
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void setImagePath(String path) async {
    try {
      imagePath.value = path;
      File imageFile = File(path);
      String downloadUrl = await uploadImage(imageFile);
      imagePath.value = downloadUrl;
      _saveUserProfile();
    } on Exception catch (e) {
      print(e);
    }
  }

  File? get profileImage =>
      imagePath.value.isNotEmpty ? File(imagePath.value) : null;

  void setUserName(String name) {
    userName.value = name;
    _saveUserProfile();
  }

  Future<void> login(String userEmail, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: userEmail, password: password);
      email.value = userEmail;
      isLoggedIn.value = true;
      await loadUserData();
      Get.snackbar('Login', 'Login berhasil untuk $userEmail');
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.message ==
            'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
          GetStorage().write(
              'pendingLogin', {'email': userEmail, 'password': password});
          Get.snackbar('Error',
              'Tidak ada koneksi internet. Data Masuk Ke Get Storage.');
        } else {
          print(e.message);
          Get.snackbar('Error', 'Login gagalz: ${e.message}');
        }
      } else {
        Get.snackbar('Error', 'Login gagall: ${e.toString()}');
      }
    }
  }

  Future<void> signUp(String userEmail, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: password);
      email.value = userEmail;
      userName.value = userEmail.split('@')[0];
      isLoggedIn.value = true;
      await _saveUserProfile();
      Get.snackbar('Daftar', 'Pendaftaran berhasil untuk $userEmail');
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.message ==
            'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
          GetStorage().write(
              'pendingRegister', {'email': userEmail, 'password': password});
          Get.snackbar('Error',
              'Tidak ada koneksi internet. Data Masuk Ke Get Storage.');
        } else {
          print(e.message);
          Get.snackbar('Error', 'Daftar gagal: ${e.message}');
        }
      } else {
        Get.snackbar('Error', 'Daftar gagall: ${e.toString()}');
      }
    }
  }

  Future<void> resignup() async {
    try {
      final storedRegister = storage.read('pendingRegister');
      if (storedRegister != null) {
        final storedEmail = storedRegister['email'];
        final storedPassword = storedRegister['password'];

        if (storedEmail != null && storedPassword != null) {
          await _auth.createUserWithEmailAndPassword(
              email: storedEmail, password: storedPassword);
          email.value = storedEmail;
          userName.value = storedEmail.split('@')[0];
          isLoggedIn.value = true;
          await _saveUserProfile();
          storage.remove('pendingRegister');
          Get.snackbar('Daftar', 'Pendaftaran berhasil untuk $storedEmail');
          Get.offAll(HomeView());
        } else {
          print("Data register tidak lengkap, resignup dibatalkan.");
        }
      } else {
        print("Tidak ada data register tersimpan.");
      }
    } catch (e) {
      Get.snackbar('Resignup', 'Resignup gagal: ${e.toString()}');
      print(e);
      print(storage.read('pendingRegister'));
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
    Get.offAll(HomeView());
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
        DocumentSnapshot userDoc =
            await _firestore.collection('pengguna').doc(email.value).get(const GetOptions(source: Source.server));
        if (userDoc.exists) {
          userName.value = userDoc['userName'] ?? email.value.split('@')[0];
          imagePath.value = userDoc['profileImagePath'] ?? '';
          balance.value =
              (userDoc['balance'] ?? 0) is int ? userDoc['balance'] : 0;
          isLoggedIn.value = true;
        } else {
          Get.snackbar('Data Pengguna', 'Data pengguna tidak ditemukan.');
        }
        Get.snackbar('Data Pengguna', 'hy');
        print(userName);
      } catch (e) {
        if(e is FirebaseException){
          if(e.message == "The service is currently unavailable. This is a most likely a transient condition and may be corrected by retrying with a backoff."){

          Get.snackbar('Hi', 'error jaringanmu lek');
          }
        }
      }
    }
  }

  void removeProfileImage() {
    imagePath.value = '';
    _saveUserProfile();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }


  Future<void> updateUserNameInFirestore(String name) async {
    final user = _auth.currentUser;

    if (user != null) {
      try {

          final pendingRequest = {
            'email': user.email!,
            'userName': name,
          };
          storage.write('pendingRequest', pendingRequest);
          Get.snackbar('Koneksi Terputus', 'Permintaan disimpan sementara.');


        // Jika koneksi tersedia, update Firestore
        await _firestore.collection('pengguna').doc(user.email!).update({
          'userName': name,
        });
        userName.value = name;
        Get.snackbar('Update Profil', 'Nama pengguna diperbarui.');
      } catch (e) {
        Get.snackbar(
            'Update Profil', 'Gagal memperbarui nama: ${e.toString()}');
      }
    }
  }

  Future <void> retryPendingRequests() async {
    final pendingRequest = storage.read('pendingRequest');
    if (pendingRequest != null) {
      try {
        await _firestore
            .collection('pengguna')
            .doc(pendingRequest['email'])
            .update({
          'userName': pendingRequest['userName'],
        });
        userName.value = pendingRequest['userName'];
        storage.remove('pendingRequest'); // Hapus permintaan setelah berhasil
        Get.snackbar('Update Profil', 'Nama pengguna diperbarui.');
      } catch (e) {
        Get.snackbar(
            'Update Profil', 'Gagal mengirim ulang permintaan: ${e.toString()}');
      }
    }
  }



  Future<String> uploadImage(File imageFile) async {
    String fileName = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // Generate a unique file name
    Reference ref = _storage.ref().child('profile_images/$fileName');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL(); // Return the download URL
  }

  Future<void> relogin() async {
    try {
      final storedLogin = storage.read('pendingLogin');
      if (storedLogin != null) {
        final storedEmail = storedLogin['email'];
        final storedPassword = storedLogin['password'];

        if (storedEmail != null && storedPassword != null) {
          await _auth.signInWithEmailAndPassword(
              email: storedEmail, password: storedPassword);

          await loadUserData(); // Memuat ulang data pengguna

          storage.remove('pendingLogin');
          print("Relogin berhasil untuk email: $storedEmail");
          Get.offAll(HomeView());
        } else {
          print("Data login tidak lengkap, relogin dibatalkan.");
        }
      } else {
        print("Tidak ada data login tersimpan.");
      }
    } catch (e) {
      Get.snackbar('Relogin', 'Relogin gagal: ${e.toString()}');
      print(e);
      print(storage.read('pendingLogin'));
    }
  }
}
