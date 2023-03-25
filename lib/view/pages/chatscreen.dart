import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/controller/chatscreen_ui_controller.dart';
import 'package:chatgpt/provider/chat_provider.dart';
import 'package:chatgpt/services/api_services.dart';
import 'package:chatgpt/view/widgets/chatbubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatscreenUiController chatscreenUiController =
      Get.put(ChatscreenUiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset(
            "assets/ChatGPT.png",
            fit: BoxFit.cover,
            // scale: size.width * .01,
          ),
        ),
        title: Text("Chat-GPT"),
        actions: [
          PopupMenuButton(
            color: scaffoldBackgroundColor,
            icon: Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                  height: 35,
                  onTap: () {
                    chatscreenUiController.clearChat();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        size: size.height * .025,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: size.width * .02,
                      ),
                      Text(
                        "Clear Chat",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ))
            ],
          )
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.more_vert_rounded,
          //       color: Colors.white,
          //     ))
        ],
      ),
      body: Obx(
        () => SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  controller: chatscreenUiController.scrollController,
                  itemCount: chatscreenUiController.chatlist.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      message: chatscreenUiController.chatlist[index].content
                          .toString(),
                      role: chatscreenUiController.chatlist[index].role,
                    );
                  },
                ),
              ),
              SizedBox(
                child: chatscreenUiController.isTyping == true
                    ? SpinKitThreeBounce(
                        color: Colors.white,
                        size: size.height * .02,
                      )
                    : SizedBox(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Material(
                  color: cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            enabled: !chatscreenUiController.isTyping.value,
                            focusNode: chatscreenUiController.focusNode,
                            style: TextStyle(color: Colors.white),
                            controller:
                                chatscreenUiController.userinputcontroller,
                            onSubmitted: (value) {
                              //todo send message
                            },
                            decoration: InputDecoration.collapsed(
                                hintText: "How can I help you",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            chatscreenUiController.isTyping.value
                                ? null
                                : chatscreenUiController.sendMessage();
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
