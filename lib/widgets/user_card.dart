import 'package:flutter/material.dart';

import '../models/user.dart';
import '../screens/contact/contact.dart';

class UserCard extends StatelessWidget {
  final User? user;

  UserCard({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed('/contact', arguments: ContactScreen(user: user!));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Container(
              child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/nsb_logo.png'),
                radius: 25,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          user!.username!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '@${user!.email}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              )
            ],
          )),
        ),
      ),
    );
  }
}
