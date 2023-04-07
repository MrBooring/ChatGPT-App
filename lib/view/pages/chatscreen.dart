import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/controller/chatscreen_ui_controller.dart';
import 'package:chatgpt/view/widgets/chatbubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatscreenUiController> {
  Constants constants = Constants();

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
        title: Text("Insight X"),
        actions: [
          IconButton(
            onPressed: () {
              controller.changeKey(context);
            },
            icon: Icon(Icons.key),
          ),
          PopupMenuButton(
            color: constants.scaffoldBackgroundColor,
            icon: Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                height: 40,
                onTap: () {
                  controller.clearChat();
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
                ),
              ),
            ],
          )
        ],
      ),
      body: Obx(
        () => SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.chatlist.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      message: controller.chatlist[index].content.toString(),
                      role: controller.chatlist[index].role,
                    );
                  },
                ),
              ),
              SizedBox(
                child: controller.isTyping == true
                    ? SpinKitThreeBounce(
                        color: Colors.white,
                        size: size.height * .02,
                      )
                    : SizedBox(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Material(
                  color: constants.cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            enabled: !controller.isTyping.value,
                            focusNode: controller.focusNode,
                            style: TextStyle(color: Colors.white),
                            controller: controller.userinputcontroller,
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
                            controller.isTyping.value
                                ? null
                                : controller.sendMessage();
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
