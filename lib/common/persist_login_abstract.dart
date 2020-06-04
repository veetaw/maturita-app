import 'persist_login_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'package:pizza/common/persist_login.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:pizza/web/persist_login.dart';

abstract class PersistLogin {
  Future<String> getToken();

  Future saveToken(String token);

  Future<bool> isLoggedIn();

  Future saveUserType(String type);

  Future<bool> isUser();

  Future deleteToken();

  Future deleteUserType();

  factory PersistLogin() => getPersistLoginImplementation();
}
