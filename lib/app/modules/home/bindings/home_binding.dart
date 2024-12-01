import 'package:get/get.dart';
import 'package:ujastore/app/modules/home/controllers/about_controller.dart';
import 'package:ujastore/app/modules/home/controllers/all_games_controller.dart';
import 'package:ujastore/app/modules/home/controllers/image_picker_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut<ImagePickerController>(() => ImagePickerController());
    Get.put(AllGamesController());
    Get.put(AboutController());
  }
}