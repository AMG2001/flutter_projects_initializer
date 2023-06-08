import 'package:get/get.dart';

class DeviceDimensions {
  static late double width;
  static late double height;
  static void init() {
    width = Get.mediaQuery.size.width;
    height = Get.mediaQuery.size.height;
  }
}
