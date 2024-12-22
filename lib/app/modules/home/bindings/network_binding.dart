import 'package:get/get.dart';
import 'package:ujastore/app/modules/home/controllers/network_controller.dart';

class NetworkBinding extends Bindings {
 @override
  void dependencies() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}