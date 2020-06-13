import 'package:flutter/foundation.dart';

const bool kIsDebug = true;

// TODO: prod API url
const String kApiBaseUrl = kIsWeb
    ? 'http://localhost:8080/api'
    : (kIsDebug
        ? 'http://api.pizza.vitp.wtf/api'
        : 'http://api.pizza.vitp.wtf/api');

// persist_login.dart
const String kTokenKey = 'token';
const String kUserTypeKey = 'type';
