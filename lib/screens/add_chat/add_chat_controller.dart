import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/custom_error.dart';
import '../../models/user.dart';

import '../../repositories/user_repository.dart';
import '../../utils/state_control.dart';
import '../../models/chat.dart';
import '../../repositories/chat_repository.dart';
import '../../screens/contact/contact.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class AddChatController extends StateControl {
  final BuildContext context;
  AddChatController({required this.context}) {
    init();
  }

  UserRepository _userRepository = UserRepository();
  ChatRepository _chatRepository = ChatRepository();

  bool _loading = true;
  bool get loading => _loading;

  bool _error = false;
  bool get error => _error;

  List<User> _users = [];
  List<User> get users => _users;

  late Chat _chat;
  late ProgressDialog _progressDialog;

  @override
  void init() {
    getUsers();
  }

  void getUsers() async {
    dynamic response = await _userRepository.getUsers();

    if (response is CustomError) {
      _error = true;
    }
    if (response is List<User>) {
      _users = response;
    }

    _loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void newChat(User user) async {
    _showProgressDialog();
    print(user.username);

    dynamic response = await _chatRepository.getChatByUsersId(user.id!);

    if (response is CustomError) {
      await _dismissProgressDialog();
      _error = true;
    }
    if (response is Chat) {
      await _dismissProgressDialog();
      _chat = await response.formatChat();
      Navigator.of(context).pushNamed(ContactScreen.routeName,
          arguments: ContactScreen(chat: _chat));
    }

    await _dismissProgressDialog();
    _loading = false;
    notifyListeners();
  }

  void _showProgressDialog() {
    _progressDialog = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false);
    _progressDialog.style(
        message: 'Loading...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CupertinoActivityIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    _progressDialog.show();
  }

  Future<bool> _dismissProgressDialog() {
    return _progressDialog.hide();
  }
}
