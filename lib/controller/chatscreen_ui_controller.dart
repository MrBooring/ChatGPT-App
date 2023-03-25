import 'dart:developer';

import 'package:chatgpt/models/chatmodel.dart';
import 'package:chatgpt/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ChatscreenUiController extends GetxController {
  var isTyping = false.obs;
  TextEditingController userinputcontroller = TextEditingController();
  var chatlist = <ChatModel>[].obs;

  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();

  sendMessage() async {
    try {
      focusNode.unfocus();
      chatlist.value
          .add(ChatModel(content: userinputcontroller.text, role: 'user'));

      //sending msg
      chatlist.value.addAll(await ChatProviders.sendMessage(
        messages: chatlist.value,
      ));
      userinputcontroller.clear();
      scrollListtoEnd();
    } catch (e) {
      log(e.toString());
    }
  }

  void scrollListtoEnd() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  void clearChat() {
    chatlist.clear();
    userinputcontroller.clear();
  }

  void dispose() {
    userinputcontroller.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
