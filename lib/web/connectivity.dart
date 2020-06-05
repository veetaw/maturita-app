import 'dart:async';
import 'package:pizza/common/connectivity_abstract.dart';

class ConnectivityServiceWeb implements ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();
  ConnectivityServiceWeb() {
    connectionStatusController.add(ConnectivityStatus.Connected);
  }
}

ConnectivityService getConnectivityService() => ConnectivityServiceWeb();
