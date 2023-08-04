import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_chat/screens/contact/contact.dart';

import '../../widgets/user_card.dart';
import './add_chat_controller.dart';

class AddChatScreen extends StatefulWidget {
  static const String routeName = '/add-chat';

  const AddChatScreen({super.key});

  @override
  State<AddChatScreen> createState() => _AddChatScreenState();
}

class _AddChatScreenState extends State<AddChatScreen> {
  late AddChatController _addChatController;

  @override
  void initState() {
    super.initState();

    _addChatController = AddChatController(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object?>(
        stream: _addChatController.streamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: CupertinoNavigationBar(
              middle: const Text(
                'Users',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: SafeArea(
                child: Container(
              child: renderusers(),
            )),
          );
        });
  }

  Widget renderusers() {
    if (_addChatController.loading) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }

    if (_addChatController.error) {
      return const Center(
        child: Text('Error occured fetching users'),
      );
    }

    if (_addChatController.users.isEmpty) {
      return const Center(
        child: Text('No users found'),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      children: _addChatController.users.map((user) {
        return Column(
          children: [
            UserCard(
              user: user,
              onTap: _addChatController.newChat,
              // onTap: () {
              //   Navigator.of(context).pushNamed(ContactScreen.routeName);
              // },
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        );
      }).toList(),
    );
  }
}
