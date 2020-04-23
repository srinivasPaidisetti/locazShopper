import 'dart:async';

import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;

  List<StreamSubscription> streamSubs = [];

  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  @override
  void dispose() async {
    for (final s in streamSubs) {
      await s.cancel();
    }
    super.dispose();
  }
}
