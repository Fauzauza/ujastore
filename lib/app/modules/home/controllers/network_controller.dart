// ignore_for_file: prefer_const_constructors

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ujastore/app/modules/home/controllers/profile_controller.dart';

class NetworkController extends GetxController {
  final ProfileController auth = Get.find();
  final Connectivity _connectivity = Connectivity(); // Inisialisasi Connectivity
  final storage = GetStorage(); // GetStorage untuk penyimpanan lokal

  @override
  void onInit() {
    super.onInit();
    // Listener untuk perubahan status koneksi
    _connectivity.onConnectivityChanged.listen((connectivityResult) {
      _updateConnectionStatus(connectivityResult.first);
    });
  }

  /// Metode untuk menangani perubahan status koneksi
  Future<void> _updateConnectionStatus(ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.none) {
      // Jika tidak ada koneksi
      Get.rawSnackbar(
        messageText: Text(
          "Koneksi Putus",
          style: TextStyle(color: Colors.white),
        ),
        isDismissible: false,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        icon: Icon(Icons.wifi_off),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      // Jika koneksi tersambung kembali
      Get.rawSnackbar(
        messageText: Text(
          "Koneksi Tersambung",
          style: TextStyle(color: Colors.white),
        ),
        isDismissible: false,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
        icon: Icon(Icons.wifi),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );

      try {
        await auth.relogin();
        print("Relogin berhasil");
      } catch (e) {
        print("Relogin gagal: $e");
        Get.snackbar(
          "Error",
          "Gagal login ulang: ${e.toString()}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      try {
        await auth.resignup();
        print("Resignup berhasil");
      } catch (e) {
        print("Resignup gagal: $e");
        Get.snackbar(
          "Error",
          "Gagal signup ulang: ${e.toString()}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      try {
        await auth.retryPendingRequests();
        print("pending berhasil");
      } catch (e) {
        print("pending gagal: $e");
        Get.snackbar(
          "Error",
          "Gagal pending ulang: ${e.toString()}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }


      Future.delayed(Duration(seconds: 1), () {
        Get.forceAppUpdate();
      });
    }
  }
}
