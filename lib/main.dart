import 'package:chatgpt/view/pages/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color: cardColor,
          )),
      home: ChatScreen(),
    );
  }
}
