import 'package:flutter/material.dart';
import 'package:pizza/common/connectivity_abstract.dart';
import 'package:pizza/common/persist_login_abstract.dart';
import 'package:pizza/models/user.dart';
import 'package:pizza/screens/common/errors/access_error_screen.dart';
import 'package:pizza/screens/common/errors/connection_error_screen.dart';
import 'package:pizza/screens/common/loading_screen.dart';
import 'package:pizza/screens/user/app_bar.dart';
import 'package:pizza/services/user_api.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:provider/provider.dart';

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
    // TODO: test this shit
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.kCardColor,
      body: LayoutBuilder(builder: (context, constraints) {
        return FutureBuilder<User>(
          future: login(userApi),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return LoadingScreen();
            if (snapshot.hasError) return ConnectionErrorScreen();

            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                CustomAppBar(
                  user: snapshot.data,
                  constraints: constraints,
                ),
              ],
            );
          },
        );
      }),
    );
  }
}

Future<User> login(UserApi api) async {
  String token = await PersistLogin().getToken();
  if (token == null) throw Exception();
  api.loginWithToken(token);
  var user = await api.info();
  return user;
}
