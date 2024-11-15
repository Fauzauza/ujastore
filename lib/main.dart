import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ujastore/app/modules/home/controllers/cart_controller.dart';
import 'package:ujastore/app/modules/home/controllers/auth_controller.dart';
import 'package:ujastore/app/modules/home/controllers/image_picker_controller.dart';
import 'package:ujastore/app/modules/home/views/welcome_view.dart';
import 'app/data/services/firebase_options.dart'; // Mengimpor konfigurasi Firebase
import 'app/routes/app_pages.dart'; // Mengimpor pengaturan routing aplikasi
import 'app/data/services/notification_handler.dart'; // Mengimpor NotificationHandler

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inisialisasi SharedPreferences dan GetStorage
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  await GetStorage.init();

  // Inisialisasi FirebaseMessagingHandler
  FirebaseMessagingHandler messagingHandler = FirebaseMessagingHandler();
  await messagingHandler.initLocalNotification();
  await messagingHandler.initPushNotification();

  // Pastikan CartController dan AuthController diinisialisasi terlebih dahulu
  Get.put(CartController(), permanent: true); // Inisialisasi CartController
  Get.put(AuthController(), permanent: true);  // Inisialisasi AuthController
  Get.put(ImagePickerController());

  // Jalankan aplikasi setelah semua inisialisasi selesai
  runApp(const MyApp());
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
      initialRoute: '/welcome', // Set WelcomeView sebagai route awal
      getPages: [
        GetPage(
          name: '/welcome',
          page: () => WelcomeView(),
          transition: Transition.fadeIn,
        ),
        ...AppPages.routes, // Tambahkan rute aplikasi lainnya
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
