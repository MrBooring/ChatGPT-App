import 'dart:developer';

import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/models/chatmodel.dart';
import 'package:chatgpt/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'shared_preff_controller.dart';

class ChatscreenUiController extends GetxController {
  var isTyping = false.obs;
  var chatlist = <ChatModel>[].obs;
  var key = "".obs;
  TextEditingController userinputcontroller = TextEditingController();
  TextEditingController apikeycontroller = TextEditingController();
  Constants constants = Constants();

  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  SharedPreffController sharedPreffController =
      Get.put(SharedPreffController());

  void onInit() {
    sharedPreffController.findKey().then((val) {
      if (val != null) {
        key.value = val;
      }
    });
    super.onInit();
  }

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
      Get.snackbar("Error", "$e");
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

  void keychanged() async {
    key.value = apikeycontroller.text;

    sharedPreffController.saveKey(key.value);
  }

  void dispose() {
    userinputcontroller.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
