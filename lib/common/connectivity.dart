import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:pizza/common/connectivity_abstract.dart';

class ConnectivityServiceMobile implements ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();
  ConnectivityServiceMobile() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Connected;
      case ConnectivityResult.none:
      default:
        return ConnectivityStatus.NotConnected;
    }
  }
}

ConnectivityService getConnectivityService() => ConnectivityServiceMobile();
