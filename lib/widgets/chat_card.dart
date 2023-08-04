import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../models/chat.dart';
import '../screens/contact/contact.dart';
import '../data/providers/chats_provider.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  ChatCard({
    super.key,
    required this.chat,
  });

  String? myId;

  var format = new DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed(
        //   ContactScreen.routeName,
        // );

        ChatsProvider _chatsProvider =
            Provider.of<ChatsProvider>(context, listen: false);
        _chatsProvider.setSelectedChat(chat);
        Navigator.of(context).pushNamed(ContactScreen.routeName);
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 15,
          top: 10,
          bottom: 0,
        ),
        child: Column(
          children: [
            Row(
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
                          // chat.messages![0].text!,
                          chat.messages![chat.messages!.length - 1].text!,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15, left: 30),
                          child: Column(
                            children: <Widget>[
                              Text(
                                messageDate(chat
                                    .messages![chat.messages!.length - 1]
                                    .createdAt!),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.blue,
                                ),
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
          ],
        ),
      ),
    );
  }

  String messageDate(int milliseconds) {
    print("milliseconds $milliseconds");
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return format.format(date);
  }

  int? _numberOfUnreadMessagesByMe() {
    return chat.messages?.where((message) => message.unreadByMe!).length;
  }

  Widget unreadMessages() {
    final _unreadMessages = _numberOfUnreadMessagesByMe();
    if (_unreadMessages == 0) {
      return Container(
        width: 0,
        height: 0,
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      color: Colors.blue,
      child: Text(
        _unreadMessages.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
