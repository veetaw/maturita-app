import 'package:flutter/material.dart';
import 'package:pizza/common/connectivity_abstract.dart';
import 'package:pizza/common/persist_login_abstract.dart';
import 'package:pizza/models/user.dart';
import 'package:pizza/screens/common/errors/access_error_screen.dart';
import 'package:pizza/screens/common/errors/connection_error_screen.dart';
import 'package:pizza/screens/common/loading_screen.dart';
import 'package:pizza/screens/user/app_bar.dart';
import 'package:pizza/screens/user/recent_orders.dart';
import 'package:pizza/services/user_api.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:provider/provider.dart';

UserApi userApi = UserApi();

class UserHome extends StatefulWidget {
  static const String kRouteName = 'userHome';

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.kCardColor,
      body: LayoutBuilder(
        builder: (_, constraints) {
          return FutureProvider<User>(
            create: (_) => login(),
            child: Consumer<User>(
              builder: (context, user, _) {
                if (user == null) return LoadingScreen();

                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    CustomAppBar(
                      user: user,
                      constraints: constraints,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: kStandardPadding,
                      ),
                    ),
                    RecentOrders(
                      api: userApi,
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

Future<User> login() async {
  String token = await PersistLogin().getToken();
  if (token == null) throw Exception();
  userApi.loginWithToken(token);
  var user = await userApi.info();
  return user;
}
