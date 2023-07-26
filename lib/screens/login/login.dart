import 'package:flutter/material.dart';

import './login_controller.dart';
import '../../widgets/my_button.dart';

class LoginScreen extends StatefulWidget {
  static final String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController? _loginController;

  @override
  void initState() {
    super.initState();

    _loginController = LoginController(context: context);
  }

  @override
  void dispose() {
    _loginController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object?>(
        stream: _loginController!.streamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            body: SafeArea(
                child: Container(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Fill in the fields below',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      TextField(
                        cursorColor: Theme.of(context).primaryColor,
                        controller: _loginController!.usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        cursorColor: Theme.of(context).primaryColor,
                        controller: _loginController!.passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        onSubmitted: (_) {
                          _loginController!.submitForm();
                        },
                        obscureText: true,
                      ),
                      MyButton(
                        title: _loginController!.formSubmitting
                            ? 'Logging in ....'
                            : 'Log in',
                        onTap: _loginController!.submitForm,
                        disabled: !_loginController!.isFormValid ||
                            _loginController!.formSubmitting,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/register');
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Don't have an account yet, create one",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ))
                    ],
                  ),
                )
              ]),
            )),
          );
        });
  }
}
