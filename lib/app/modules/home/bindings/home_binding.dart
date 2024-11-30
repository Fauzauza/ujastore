import 'package:get/get.dart';
import 'package:ujastore/app/modules/home/controllers/all_games_controller.dart';
import 'package:ujastore/app/modules/home/controllers/cart_controller.dart';
import 'package:ujastore/app/modules/home/controllers/image_picker_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ImagePickerController>(() => ImagePickerController());
    Get.lazyPut<CartController>(() => CartController());
    Get.put(AllGamesController());
  }
}