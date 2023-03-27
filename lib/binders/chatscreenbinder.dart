import 'package:chatgpt/controller/chatscreen_ui_controller.dart';
import 'package:get/instance_manager.dart';

class chatScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatscreenUiController>(() => ChatscreenUiController(),
        fenix: true);
  }
}
