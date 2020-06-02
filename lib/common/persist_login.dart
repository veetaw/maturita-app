import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pizza/common/persist_login_abstract.dart';
import 'package:pizza/constants.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

class PersistLoginMobile implements PersistLogin {
  Future<String> getToken() async => storage.read(key: kTokenKey);

  Future saveToken(String token) async =>
      storage.write(key: kTokenKey, value: token);

  Future<bool> isLoggedIn() async {
    String token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future saveUserType(String type) async =>
      storage.write(key: kUserTypeKey, value: type);

  Future<bool> isUser() async {
    String type = await storage.read(key: kUserTypeKey);
    return type != null && type.isNotEmpty && type.toLowerCase() == 'user';
  }
}

PersistLogin getPersistLoginImplementation() => PersistLoginMobile();
