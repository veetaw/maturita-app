import 'package:flutter/material.dart';
import 'package:pizza/screens/common/errors/connection_error_screen.dart';
import 'package:pizza/screens/owner/owner_home.dart';

import 'package:pizza/screens/auth/auth.dart';
import 'package:pizza/screens/user/edit_user.dart';
import 'package:pizza/screens/user/user_home.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (BuildContext context) {
      switch (settings.name) {
        case 'network_error':
          return Scaffold(
            body: ConnectionErrorScreen(),
          );
        case Login.kRouteName:
          return Login();
        case UserHome.kRouteName:
          return UserHome();
        case OwnerHome.kRouteName:
          return OwnerHome();
        case RegisterUser.kRouteName:
          return RegisterUser();
        case RegisterOwner.kRouteName:
          return RegisterOwner();
        case CreatePizzeria.kRouteName:
          return CreatePizzeria(
            api: settings.arguments,
          );
        case CreateOpenings.kRouteName:
          return CreateOpenings(
            api: settings.arguments,
          );
        case CreateMenu.kRouteName:
          return CreateMenu(
            api: settings.arguments,
          );
        case EditUser.kRouteName:
          return EditUser();
        default:
          return Scaffold(body: Text('unknown route'));
      }
    },
  );
}
