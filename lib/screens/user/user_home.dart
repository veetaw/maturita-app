import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  static const String kRouteName = 'userHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Text('user'),      
    );
  }
}