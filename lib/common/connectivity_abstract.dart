import 'dart:async';

import 'connectivity_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'package:pizza/common/connectivity.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:pizza/web/connectivity.dart';

abstract class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController;

  factory ConnectivityService() => getConnectivityService();
}

enum ConnectivityStatus {
  Connected,
  NotConnected,
}
