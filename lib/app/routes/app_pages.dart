import 'package:get/get.dart';
import 'package:ujastore/app/data/models/product_model.dart';
import 'package:ujastore/app/modules/home/bindings/cart_binding.dart';
import 'package:ujastore/app/modules/home/bindings/home_binding.dart';
import 'package:ujastore/app/modules/home/views/cart_view.dart';
import 'package:ujastore/app/modules/home/views/login_view.dart';
import 'package:ujastore/app/modules/home/views/settings_page.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/product_detail_view.dart';
import 'app_routes.dart'; // Pastikan import app_routes.dart

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME, // Gunakan Routes.HOME
      page: () => HomeView(),
      binding: HomeBinding()
    ),
    GetPage(
      name: Routes.PRODUCT_DETAIL, // Gunakan Routes.PRODUCT_DETAIL
      page: () {
        // Mengambil argumen product dari rute
        final product = Get.arguments as Product; // Cast argumen ke Product
        return ProductDetailView(product: product);
      },
    ),
    GetPage(
      name: Routes.LOGIN, // Gunakan Routes.LOGIN
      page: () => LoginView(),
    ),
    GetPage(
      name: Routes.SETTINGS, // Gunakan Routes.SETTINGS
      page: () => SettingsPage(),
    ),
    GetPage(
        name: Routes.CART, // Gunakan Routes.HOME
        page: () => CartView(),
        binding: CartBinding()),
  ];
}
