import 'package:get/get.dart';
import 'package:ujastore/app/modules/home/controllers/cart_controller.dart';

class CartBinding extends Bindings {
  
  @override
  void dependencies() {
  Get.put(CartController());
  } // Inisialisasi CartController

}