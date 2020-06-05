import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pizza/common/connectivity_abstract.dart';

import 'package:pizza/router.dart';
import 'package:pizza/common/persist_login_abstract.dart';
import 'package:pizza/models/item.dart';
import 'package:pizza/models/opening.dart';
import 'package:pizza/models/order.dart';
import 'package:pizza/models/owner.dart';
import 'package:pizza/models/pizzeria.dart';
import 'package:pizza/models/user.dart';
import 'package:pizza/screens/auth/login.dart';
import 'package:pizza/screens/common/errors/connection_error_screen.dart';
import 'package:pizza/screens/owner/owner_home.dart';
import 'package:pizza/screens/user/user_home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.initFlutter();

  // register hive adapters
  Hive.registerAdapter<Item>(ItemAdapter());
  Hive.registerAdapter<Opening>(OpeningAdapter());
  Hive.registerAdapter<Order>(OrderAdapter());
  Hive.registerAdapter<Owner>(OwnerAdapter());
  Hive.registerAdapter<Pizzeria>(PizzeriaAdapter());
  Hive.registerAdapter<User>(UserAdapter());

  bool loggedIn;
  bool user;
  PersistLogin persistLogin = PersistLogin();

  loggedIn = await persistLogin.isLoggedIn();
  user = await persistLogin.isUser();
  // TODO: debug
  // loggedIn = false;
  // user = null;

  runApp(
    App(
      loggedIn: loggedIn,
      isUser: user,
    ),
  );
}

class App extends StatelessWidget {
  final bool loggedIn;
  final bool isUser;

  const App({
    @required this.loggedIn,
    @required this.isUser,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      create: (context) =>
          ConnectivityService().connectionStatusController.stream,
      child: Builder(
        builder: (context) {
          // TODO
          // if (status == null) {
          //   return MaterialApp(
          //     home: Scaffold(
          //       body: Center(
          //         child: CircularProgressIndicator(),
          //       ),
          //     ),
          //   );
          // }
          // if (status == ConnectivityStatus.NotConnected)
          //   return MaterialApp(
          //     home: Scaffold(
          //       body: ConnectionErrorScreen(),
          //     ),
          //   );
          return MaterialApp(
            initialRoute: loggedIn
                ? (isUser ? UserHome.kRouteName : OwnerHome.kRouteName)
                : Login.kRouteName,
            onGenerateRoute: onGenerateRoute,
          );
        },
      ),
    );
  }
}
