import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:chatgpt/models/chatmodel.dart';
import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/controller/chatscreen_ui_controller.dart';

class ChatProviders {
  static Future<List<ChatModel>> sendMessage({required messages}) async {
    List<ChatModel> chatlist = [];
    try {
      ChatscreenUiController chatscreenUiController =
          Get.find<ChatscreenUiController>();
      chatscreenUiController.isTyping.value = true;
      var responce = await http.post(
        Uri.parse("$baseuri/v1/chat/completions"),
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(
          {
            "model": apiid,
            "messages": messages,
            "max_tokens": 500,
          },
        ),
      );

      Map jsonResponce = jsonDecode(responce.body);
      if (jsonResponce['error'] != null) {
        Get.snackbar("Error", jsonResponce['error']['message'].toString(),
            colorText: const Color(0xFFFFFFFF));
      }

      if (jsonResponce['choices'] != null) {
        if (jsonResponce['choices'].length > 0) {
          log(jsonResponce['choices'][0]['message']['content'].toString());
          chatlist = List.generate(
            jsonResponce['choices'].length,
            (index) => ChatModel(
                content: jsonResponce['choices'][0]['message']['content'],
                role: "assistant"),
          );
        }
      }
      chatscreenUiController.isTyping.value = false;
    } catch (e) {
      Get.snackbar("Error", e.toString(), colorText: const Color(0xFFFFFFFF));
    }
    return chatlist;
  }
}
