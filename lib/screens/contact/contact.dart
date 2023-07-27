import 'package:flutter/material.dart';

import './contact_controller.dart';
import '../../models/chat.dart';

class ContactScreen extends StatefulWidget {
  final Chat chat;
  const ContactScreen({super.key, required this.chat});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  ContactController? _contactController;

  @override
  void initState() {
    super.initState();

    _contactController = ContactController(
      context: context,
      chat: widget.chat,
    );
  }

  @override
  void dispose() {
    _contactController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object?>(
        stream: _contactController!.streamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: const Color(0xffeeeeeeee),
            appBar: AppBar(
                title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _contactController!.chat.otherUser!.username!,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                renderOnline(),
              ],
            )),
            body: SafeArea(
                child: Container(
              child: Column(children: [
                Expanded(
                  child: ListView(
                    reverse: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 5,
                        ),
                        child: renderMessages(context),
                      )
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      height: 55,
                      child: Row(children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  cursorColor: Theme.of(context).primaryColor,
                                  controller:
                                      _contactController!.textEditingController,
                                  onSubmitted: (_) {
                                    _contactController!.sendMessage();
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 0),
                                    hintText: 'Type a message',
                                    hintStyle: TextStyle(fontSize: 16),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Material(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50),
                          child: InkWell(
                            onTap: _contactController!.sendMessage,
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                )
              ]),
            )),
          );
        });
  }

  Widget renderMessages(BuildContext context) {
    return Column(
      children: _contactController!.chat.messages!.map((message) {
        return Column(
          children: [
            Material(
              color: Colors.transparent,
              child: Align(
                alignment: message.userId == _contactController!.chat.myUser!.id
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  constraints:
                      const BoxConstraints(maxWidth: double.infinity - 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 2,
                    ),
                    color: message.userId == _contactController!.chat.myUser!.id
                        ? const Color(0xFFC0CBFF)
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Text(
                        message.text!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget renderOnline() {
    // if (_contactController!.chatOnlineInMyChat) {
    //   return const Text(
    //     'online in your conversation',
    //     style: TextStyle(
    //         fontSize: 12,
    //         fontWeight: FontWeight.bold,
    //         color: Colors.greenAccent),
    //   );
    // }
    return const SizedBox(
      width: 0,
      height: 0,
    );
  }
}
