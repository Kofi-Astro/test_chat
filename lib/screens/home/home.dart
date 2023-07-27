import 'package:flutter/material.dart';

import './home_controller.dart';
import '../../widgets/user_card.dart';

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
            appBar: AppBar(
              title: const Text(
                'Users online',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: [
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    onPressed: _homeController!.logout,
                  ),
                )
              ],
            ),
            body: SafeArea(
                child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  child: Container(child: userList(context)),
                )
              ],
            )),
          );
        });
  }

  Widget userList(BuildContext context) {
    if (_homeController!.users.isEmpty) {
      return const Material(
        child: Align(
          alignment: Alignment.center,
          child: Text('No user online'),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _homeController!.users.map((user) {
        return Column(
          children: [
            UserCard(
              user: user,
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
