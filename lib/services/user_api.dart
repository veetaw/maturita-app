import 'package:pizza/models/item.dart';
import 'package:pizza/models/order.dart';
import 'package:pizza/models/pizzeria.dart';
import 'package:pizza/models/user.dart';
import 'package:pizza/services/api.dart';

import 'package:flutter/material.dart';

class UserApi extends PizzaApi {
  Future<bool> register({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String address,
    @required String phone,
    @required String password,
    String profilePicture,
  }) async {
    const path = '/auth/registerUser';
    final Map<String, dynamic> body = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'address': address,
      'phone': phone,
      'password': password,
      'profile_picture': profilePicture,
    };

    return (await super.post(path: path, body: body)).data['success'];
  }

  Future<String> login({
    @required String email,
    @required String password,
  }) async {
    const path = '/auth/loginUser';
    final Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    String token = (await super.post(path: path, body: body)).data['token'];

    loginWithToken(token);

    return token;
  }

  void loginWithToken(String token) {
    if (token == null || token.isEmpty) throw Exception();

    // register token interceptor
    super.addInterceptor(super.getTokenInterceptor(token));
  }

  Future<User> info() async {
    const path = '/user/info';
    return User.fromJson((await super.get(path: path)).data);
  }

  Future<List<Pizzeria>> pizzerie() async {
    const path = '/user/pizzerie';
    return ((await super.get(path: path)).data['pizzerie'] as List)
        .map((pizzeria) => Pizzeria.fromJson(pizzeria))
        .toList();
  }

  Future<Pizzeria> pizzeria({
    @required int id,
  }) async {
    const path = '/user/pizzeria';
    return Pizzeria.fromJson(
      (await super.get(path: path, parameters: {'id': id})).data,
    );
  }

  Future<List<Order>> orders() async {
    const path = '/user/orders';

    return ((await super.get(path: path)).data['orders'] as List)
        .map((order) => Order.fromJson(order))
        .toList();
  }

  Future<Order> createOrder({
    @required Pizzeria pizzeria,
    @required List<Item> items,
  }) async {
    const path = '/user/order';
    final Map<String, dynamic> body = {
      'pizzeria_id': pizzeria.id,
      'item_list': items.map((item) => item.toJsonSimple()).toList()
    };
    return Order.fromJson(
        (await super.post(path: path, body: body)).data['newOrder']);
  }

  Future<Order> order({
    @required int id,
  }) async {
    const path = '/user/order';
    return Order.fromJson(
      (await super.get(path: path, parameters: {'id': id})).data['order'],
    );
  }
}
