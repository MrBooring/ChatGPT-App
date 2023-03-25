import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message, required this.role});

  final String message;

  final String role;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: role == 'user' ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  role != 'user' ? "assets/ai.png" : "assets/user.png",
                  height: size.height * .03,
                  width: size.width * .05,
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                Expanded(
                  child: role == 'user'
                      ? Text(
                          message.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            // letterSpacing: 1,
                            fontSize: size.height * .02,
                            fontWeight: FontWeight.w500,

                            letterSpacing: .5,
                          ),
                        )
                      : DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.white,
                            // letterSpacing: 1,
                            fontSize: size.height * .02,
                            fontWeight: FontWeight.w500,

                            letterSpacing: .5,
                          ),
                          child: GestureDetector(
                            onDoubleTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  content: SelectableText(
                                    message,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              repeatForever: false,
                              totalRepeatCount: 0,
                              displayFullTextOnTap: true,
                              animatedTexts: [
                                TyperAnimatedText(
                                  message.trim(),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
