import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  final int miliseconds;
  VoidCallback actions;
  Timer _timer;
  Debouncer({this.miliseconds});

  run(VoidCallback actions) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(microseconds: miliseconds), actions);
  }
}
