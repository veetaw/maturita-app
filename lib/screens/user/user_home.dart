import 'package:flutter/material.dart';
import 'package:pizza/common/persist_login_abstract.dart';
import 'package:pizza/screens/common/errors/access_error_screen.dart';
import 'package:pizza/services/user_api.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:undraw/undraw.dart';

class UserHome extends StatefulWidget {
  static const String kRouteName = 'userHome';

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  UserApi userApi = UserApi();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: login(userApi),
        builder: (context, snapshot) {
          // if (snapshot.connectionState != ConnectionState.done)
          // return LoadingScreen();
          // if (snapshot.hasError)
          // return ConnectionErrorScreen();
          // return AccessErrorScreen();
        },
      ),
    );
  }
}

Future login(UserApi api) async {
  String token = await PersistLogin().getToken();
  if (token == null) throw Exception();
  return api.loginWithToken(token);
}
