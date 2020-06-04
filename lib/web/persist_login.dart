// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:pizza/common/persist_login_abstract.dart';
import 'package:pizza/constants.dart';

Window windowLoc;

class PersistLoginWeb implements PersistLogin {
  PersistLoginWeb() {
    windowLoc = window;
  }
  Future<String> getToken() async =>
      Future.value(windowLoc.localStorage[kTokenKey]);

  Future saveToken(String token) async =>
      Future.value(windowLoc.localStorage[kTokenKey] = token);

  Future<bool> isLoggedIn() async {
    String token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future saveUserType(String type) async =>
      Future.value(windowLoc.localStorage[kUserTypeKey] = type);

  Future<bool> isUser() async {
    String type = windowLoc.localStorage[kUserTypeKey];
    return type != null && type.isNotEmpty && type.toLowerCase() == 'user';
  }

  @override
  Future deleteToken() async => windowLoc.localStorage.remove(kTokenKey);

  @override
  Future deleteUserType() async => windowLoc.localStorage.remove(kUserTypeKey);
}

PersistLogin getPersistLoginImplementation() => PersistLoginWeb();
