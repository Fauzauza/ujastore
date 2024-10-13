import 'package:get/get.dart';
import 'package:ujastore/app/data/models/product_model.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/product_detail_view.dart';
import '../modules/home/views/github_repo_info_page.dart'; // Pastikan mengimpor halaman GitHub
import 'app_routes.dart'; // Pastikan import app_routes.dart

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
    ),
    GetPage(
      name: Routes.PRODUCT_DETAIL,
      page: () {
        final product = Get.arguments as Product;
        return ProductDetailView(product: product);
      },
    ),
    GetPage(
      name: Routes.GITHUB_REPO_INFO, // Menggunakan rute GitHub
      page: () => GitHubRepoInfoPage(), // Halaman untuk GitHub
    ),
  ];
}

class GITHUB_REPO_INFO {}
