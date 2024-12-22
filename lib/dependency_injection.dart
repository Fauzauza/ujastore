

import 'package:ujastore/app/modules/home/bindings/network_binding.dart';

class DependencyInjection {
  static void init() {
    NetworkBinding().dependencies();
  }
}
