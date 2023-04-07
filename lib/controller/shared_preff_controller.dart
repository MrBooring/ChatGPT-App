import 'package:chatgpt/controller/chatscreen_ui_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreffController extends GetxController {
  findKey() async {
    // ChatscreenUiController chatscreenUiController =
    //     Get.find<ChatscreenUiController>();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? keys = prefs.getString('key');
    if (keys != null) {
      // chatscreenUiController.key.value = keys;
      return keys;
    } else {
      Get.snackbar(
        "Alert",
        "No Api key found please provide one from https://platform.openai.com/account/api-keys ",
        colorText: Color(0xFFFFFFFF),
      );
      return null;
    }
  }

  saveKey(key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('key', '$key').then((value) {
      Get.snackbar(
        "New Key Found",
        "Your New Key is ${key} Please verify it before using",
        colorText: const Color(0xFFFFFFFF),
      );
    });
  }
}
