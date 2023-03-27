import 'package:chatgpt/binders/chatscreenbinder.dart';
import 'package:chatgpt/view/pages/chatscreen.dart';
import 'package:get/get.dart';

var routes = [
  GetPage(
    name: "/",
    page: () => ChatScreen(),
    binding: chatScreenBindings(),
  ),
];
