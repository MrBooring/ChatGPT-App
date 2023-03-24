import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/controller/chatscreen_ui_controller.dart';
import 'package:chatgpt/models/chatmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatProviders {
  static Future<List<ChatModel>> sendMessage({required String message}) async {
    List<ChatModel> chatlist = [];
    try {
      ChatscreenUiController chatscreenUiController =
          Get.find<ChatscreenUiController>();
      chatscreenUiController.isTyping.value = true;
      var responce = await http.post(
        Uri.parse("$baseuri/v1/completions"),
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(
          {
            "model": apiid,
            "prompt": message,
            "max_tokens": 200,
          },
        ),
      );

      Map jsonResponce = jsonDecode(responce.body);
      if (jsonResponce['error'] != null) {
        Get.snackbar("Error", jsonResponce['error']['message'].toString());
        // throw HttpException(jsonResponce['error']['message']);
      }

      if (jsonResponce['choices'].length > 0) {
        // log(jsonResponce['choices'][0]['text']);
        chatlist = List.generate(
          jsonResponce['choices'].length,
          (index) => ChatModel(
              message: jsonResponce['choices'][0]['text'], chatIndex: 1),
        );
      }
      chatscreenUiController.isTyping.value = false;
    } catch (e) {
      print(e);
    }
    return chatlist;
  }
}
