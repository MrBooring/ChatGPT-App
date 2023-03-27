import 'package:chatgpt/binders/chatscreenbinder.dart';
import 'package:chatgpt/view/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//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
  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: constants.scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color: constants.cardColor,
          )),
      getPages: routes,
      initialRoute: '/',
    );
  }
}
