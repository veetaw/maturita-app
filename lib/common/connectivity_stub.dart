import 'dart:async';

import 'package:pizza/common/connectivity_abstract.dart';

class ConnectivityServiceStub implements ConnectivityService {
  @override
  StreamController<ConnectivityStatus> connectionStatusController;
}

ConnectivityService getConnectivityService() => ConnectivityService();
