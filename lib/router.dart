import 'package:flutter/material.dart';
import 'package:pizza/screens/owner/owner_home.dart';

import 'package:pizza/screens/auth/auth.dart';
import 'package:pizza/screens/user/user_home.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (BuildContext context) {
      switch (settings.name) {
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
          return CreatePizzeria();
        case CreateOpenings.kRouteName:
          return CreateOpenings();
        case CreateMenu.kRouteName:
          return CreateMenu();
        default:
          return Text('unknown route');
      }
    },
  );
}