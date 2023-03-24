import 'package:chatgpt/models/chatmodel.dart';
import 'package:chatgpt/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ChatscreenUiController extends GetxController {
  var isTyping = false.obs;
  TextEditingController userinputcontroller = TextEditingController();
  var chatlist = <ChatModel>[].obs;

  sendMessage() async {
    chatlist.value = await ChatProviders.sendMessage(
      message: "${userinputcontroller.text.toString()}",
    );
  }

  void dispose() {
    userinputcontroller.dispose();
    super.dispose();
  }
}
