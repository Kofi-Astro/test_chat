
import 'package:flutter/material.dart';

import '../models/chat.dart';
import '../screens/contact/contact.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  ChatCard({
    super.key,
    required this.chat,
  });

  String? myId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/contact', arguments: ContactScreen(chat: chat));
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 15,
          top: 10,
          bottom: 0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/nsb_logo.png'),
              radius: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  bottom: 5,
                ),
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      chat.otherUser!.username!,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      chat.messages![0].text!,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: const Color(0xffdddddd),
                    )
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
