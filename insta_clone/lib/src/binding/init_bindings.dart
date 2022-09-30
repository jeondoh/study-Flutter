import 'package:get/get.dart';
import 'package:insta_clone/src/controller/bottom_nav_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    // 앱 종료시 까지 인스턴스 유지
    Get.put(BottomNavController(), permanent: true);
  }
}
