import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'app/data/services/firebase_options.dart'; // Mengimpor konfigurasi Firebase
import 'app/routes/app_pages.dart'; // Mengimpor pengaturan routing aplikasi
import 'app/modules/home/controllers/auth_controller.dart'; // Mengimpor AuthController
import 'app/data/services/notification_handler.dart'; // Mengimpor NotificationHandler

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Memastikan binding sudah diinisialisasi

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inisialisasi SharedPreferences
  await Get.putAsync(() async => await SharedPreferences.getInstance());

  // Inisialisasi GetStorage
  await GetStorage.init();

  // Inisialisasi FirebaseMessagingHandler
  FirebaseMessagingHandler messagingHandler = FirebaseMessagingHandler();
  await messagingHandler.initLocalNotification(); // Memanggil initLocalNotification()
  await messagingHandler.initPushNotification(); // Memanggil initPushNotification()

  // Inisialisasi AuthController
  Get.put(AuthController());

  // Jalankan aplikasi setelah inisialisasi selesai
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    bool isDarkMode = box.read('isDarkMode') ?? false; // Memeriksa mode gelap

    return GetMaterialApp(
      title: 'ujastore.id',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(), // Mengatur tema aplikasi
      initialRoute: AppPages.INITIAL, // Menentukan route awal
      getPages: AppPages.routes, // Mengatur routing aplikasi
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
    );
  }
}
