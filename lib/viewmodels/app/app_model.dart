import 'package:connectivity/connectivity.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:locazshopper/services/navigation_service.dart';

import '../base_model.dart';

class AppModel extends BaseModel {
  NavigationService _navigationService;
  Connectivity connectivity = Connectivity();
  bool _isOnline = true;
  ConnectivityResult _connectivityResult;

  ConnectivityResult get connectivityResult => _connectivityResult;

  set connectivityResult(ConnectivityResult connectivityResult) {
    _connectivityResult = connectivityResult;
    notifyListeners();
  }

  bool get isOnline => _isOnline;

  set isOnline(bool isOnline1) {
    _isOnline = isOnline1;
    notifyListeners();
  }

  AppModel({@required NavigationService navigationService})
      : _navigationService = navigationService;

  get navationKey => _navigationService.navigationKey;

  void startBackgroundSevice(bool isFreshInstall) {
    if (isFreshInstall) {
      Connectivity().checkConnectivity().then((result) {
        _getStatusFromResult(result);
      });
    }
  }

  checkConnectivity() {
    streamSubs.add(Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _getStatusFromResult(result);
    }));
  }

  _getStatusFromResult(
    ConnectivityResult result,
  ) {
    switch (result) {
      case ConnectivityResult.mobile:
        isOnline = true;
        connectivityResult = ConnectivityResult.mobile;
        Fimber.i("connection status $isOnline");
        return;
      case ConnectivityResult.wifi:
        isOnline = true;
        connectivityResult = ConnectivityResult.wifi;
        Fimber.i("connection status $isOnline");
        return;
      case ConnectivityResult.none:
        isOnline = false;
        connectivityResult = ConnectivityResult.none;
        Fimber.i("connection status $isOnline");
        return;
      default:
        isOnline = false;
        connectivityResult = ConnectivityResult.none;
        Fimber.i("connection status $isOnline");
        return;
    }
  }
}
