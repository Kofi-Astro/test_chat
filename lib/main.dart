import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './screens/home/home.dart';
import './screens/login/login.dart';
import './screens/onboarding/onboarding.dart';
import './screens/register/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(
                builder: (_) => const OnboardingScreen(), settings: settings);
          case '/login':
            return CupertinoPageRoute(
                builder: (_) => const LoginScreen(), settings: settings);

          case '/register':
            return CupertinoPageRoute(
                builder: (_) => const RegisterScreen(), settings: settings);
          case '/home':
            return CupertinoPageRoute(
                builder: (_) => const HomeScreen(), settings: settings);
          // case '/contact':
          //   return CupertinoPageRoute(
          //       builder: (_) => ContactScreen(
          //             user: user,
          //           ),
          //       settings: settings);

          default:
            return CupertinoPageRoute(
                builder: (_) => const OnboardingScreen(), settings: settings);
        }
      },
    );
  }
}
