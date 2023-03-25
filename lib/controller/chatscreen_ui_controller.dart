import 'dart:developer';

import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/models/chatmodel.dart';
import 'package:chatgpt/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatscreenUiController extends GetxController {
  var isTyping = false.obs;
  TextEditingController userinputcontroller = TextEditingController();
  TextEditingController apikeycontroller = TextEditingController();
  var chatlist = <ChatModel>[].obs;
  Constants constants = Constants();

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

  Future<void> changeKey(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: constants.cardColor,
          title: const Text(
            "Change Your Api Key",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            style: TextStyle(color: Colors.white),
            controller: apikeycontroller,
            onSubmitted: (value) {
              //todo send message
            },
            decoration: const InputDecoration.collapsed(
                hintText: "Enter Your Key",
                hintStyle: TextStyle(color: Colors.grey)),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async {
                    Get.snackbar(
                      "Alert",
                      "Please Visit https://platform.openai.com/account/api-keys for a new key",
                      colorText: Color(0xFFFFFFFF),
                    );
                  },
                  icon: Icon(
                    Icons.question_mark,
                    size: size.height * .02,
                    color: Colors.white,
                  ),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    keychanged();

                    Navigator.pop(context);
                  },
                  child: Text("Submit"),
                  style: FilledButton.styleFrom(
                    backgroundColor: constants.scaffoldBackgroundColor,
                  ),
                ),
              ],
            )
          ],
        );
      },
    ).then((value) {
      apikeycontroller.clear();
    });
  }

  void keychanged() {
    constants.key = apikeycontroller.text;
    Get.snackbar(
      "New Key Found",
      "Your New Key is ${constants.key} Please verify it before using",
      colorText: const Color(0xFFFFFFFF),
    );
  }

  void dispose() {
    userinputcontroller.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
