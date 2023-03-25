import 'dart:convert';
import 'dart:io';

import 'package:chatgpt/constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> getModels() async {
    Constants constants = Constants();

    try {
      var responce = await http.get(Uri.parse("${constants.baseuri}/v1/models"),
          headers: {'Authorization': 'Bearer ${constants.key}'});

      Map jsonResponce = jsonDecode(responce.body);
      if (jsonResponce['error'] != null) {
        Get.snackbar("Error", jsonResponce['error']['message'].toString());
        throw HttpException(jsonResponce['error']['message']);
      }
      print(jsonResponce);
    } catch (e) {
      print(e);
    }
  }
}
