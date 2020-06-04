import 'package:flutter/foundation.dart';

const bool kIsDebug = true;

// TODO: prod API url
const String kApiBaseUrl = kIsWeb
    ? 'http://localhost:3000/api'
    : (kIsDebug ? 'http://192.168.1.245:3000/api' : '');

// persist_login.dart
const String kTokenKey = 'token';
const String kUserTypeKey = 'type';
