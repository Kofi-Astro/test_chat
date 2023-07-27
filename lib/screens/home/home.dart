import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './home_controller.dart';
import '../../widgets/chat_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController? _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = HomeController(context: context);
  }

  @override
  void dispose() {
    _homeController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object?>(
        stream: _homeController!.streamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
              body: CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    largeTitle: const Text(
                      'Chats',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Material(
                      color: Colors.transparent,
                      child: IconButton(
                          onPressed: _homeController!.logout,
                          icon: const Icon(Icons.exit_to_app)),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  SliverFillRemaining(
                    child: userList(context),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: _homeController!.openAddChatScreen,
                child: const Icon(Icons.add),
              ));
        });
  }

  Widget userList(BuildContext context) {
    if (_homeController!.loading) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }

    if (_homeController!.error) {
      return const Center(
        child: Text('Error occured'),
      );
    }

    if (_homeController!.chats.isEmpty) {
      return const Center(
        child: Text('No existing chat'),
      );
    }

    bool chatsWithMessages = _homeController!.chats.where((chat) {
      return chat.messages!.isNotEmpty;
    }).isNotEmpty;

    if (!chatsWithMessages) {
      return const Center(
        child: Text('No chat exist'),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      children: _homeController!.chats.map((chat) {
        if (chat.messages!.isEmpty) {
          return const SizedBox(
            height: 0,
            width: 0,
          );
        }

        return Column(
          children: [
            ChatCard(chat: chat),
            const SizedBox(
              height: 5,
            )
          ],
        );
      }).toList(),
    );
  }
}
