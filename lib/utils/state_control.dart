import 'dart:async';

import './state_abstract_control.dart';

class StateControl implements StateAbstractControl {
  final StreamController streamController;

  StateControl() : streamController = StreamController();

  void notifyListeners() {
    streamController.add('change');
  }

  void init() {
    print('Initializing state');
  }

  void dispose() {
    print('Disposing state');
    streamController.close();
  }
}
