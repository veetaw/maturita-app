import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:pizza/common/persist_login.dart';

import 'package:pizza/router.dart';

import 'package:pizza/models/item.dart';
import 'package:pizza/models/opening.dart';
import 'package:pizza/models/order.dart';
import 'package:pizza/models/owner.dart';
import 'package:pizza/models/pizzeria.dart';
import 'package:pizza/models/user.dart';
import 'package:pizza/screens/auth/login.dart';
import 'package:pizza/screens/owner/owner_home.dart';
import 'package:pizza/screens/user/user_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // register hive adapters
  Hive.registerAdapter<Item>(ItemAdapter());
  Hive.registerAdapter<Opening>(OpeningAdapter());
  Hive.registerAdapter<Order>(OrderAdapter());
  Hive.registerAdapter<Owner>(OwnerAdapter());
  Hive.registerAdapter<Pizzeria>(PizzeriaAdapter());
  Hive.registerAdapter<User>(UserAdapter());

  bool loggedIn;
  bool user;

  if (kIsWeb) // TODO
    loggedIn = false;
  else {
    loggedIn = await isLoggedIn();
    user = await isUser();
  }

  runApp(App(loggedIn: loggedIn, isUser: user));
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
    return MaterialApp(
      initialRoute: loggedIn
          ? (isUser ? UserHome.kRouteName : OwnerHome.kRouteName)
          : Login.kRouteName,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
