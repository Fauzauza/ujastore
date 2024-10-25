import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:ujastore/app/modules/home/controllers/auth_controller.dart'; // Sesuaikan path ini
import 'app/routes/app_pages.dart'; // Sesuaikan path ini
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Firebase dengan penanganan error
  await _initializeFirebase();

  // Inisialisasi GetStorage
  await GetStorage.init();

  // Inisialisasi AuthController setelah GetStorage siap
  Get.put(AuthController());

  // Jalankan aplikasi setelah inisialisasi selesai
  runApp(const MyApp());
}

Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(); // Inisialisasi Firebase
    print('Firebase Initialized Successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    bool isDarkMode = box.read('isDarkMode') ?? false;

    return GetMaterialApp(
      title: 'ujastore.id',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false, // Optional: Menghilangkan banner debug
    );
  }
}
