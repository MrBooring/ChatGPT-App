import 'package:chatgpt/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key, required this.message, required this.messageIndex});

  final String message;

  final int messageIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: messageIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  messageIndex != 0 ? "assets/ai.png" : "assets/user.png",
                  height: size.height * .03,
                  width: size.width * .05,
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                Expanded(
                  child: Text(
                    message.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.height * .02,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
