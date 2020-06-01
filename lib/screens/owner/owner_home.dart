import 'package:flutter/material.dart';

class OwnerHome extends StatelessWidget {
  static const String kRouteName = 'ownerHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Text('owner'),      
    );
  }
}