import 'package:flutter/material.dart';
import 'package:pizza/common/connectivity_abstract.dart';
import 'package:provider/provider.dart';

class OwnerHome extends StatelessWidget {
  static const String kRouteName = 'ownerHome';
  @override
  Widget build(BuildContext context) {
    if (Provider.of<ConnectivityStatus>(context) ==
        ConnectivityStatus.NotConnected)
      Navigator.of(context).pushReplacementNamed('network_error');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Text('owner'),
    );
  }
}
