import 'package:flutter/material.dart';
import 'package:pizza/models/item.dart';
import 'package:pizza/models/opening.dart';
import 'package:pizza/models/order.dart';
import 'package:pizza/models/pizzeria.dart';
import 'package:pizza/models/owner.dart';

import 'package:pizza/services/api.dart';

class OwnerApi extends PizzaApi {
  Future<bool> register({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password,
    String profilePicture,
  }) async {
    const path = '/auth/registerOwner';
    final Map<String, dynamic> body = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'profile_picture': profilePicture,
    };
    return (await super.post(path: path, body: body)).data['success'];
  }

  Future<String> login({
    @required String email,
    @required String password,
  }) async {
    const path = '/auth/loginOwner';
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

  Future<Owner> info() async {
    const path = '/owner/info';
    return Owner.fromJson((await super.get(path: path)).data);
  }

  Future<Pizzeria> createPizzeria({
    @required String name,
    @required String pIva,
    @required String address,
    @required String phone,
    @required String email,
    String profilePicture,
  }) async {
    const path = '/owner/pizzeria';
    final body = {
      'name': name,
      'p_iva': pIva,
      'address': address,
      'phone': phone,
      'email': email,
      'profile_picture': profilePicture,
    };
    return Pizzeria.fromJson(
        (await super.post(path: path, body: body)).data['pizzeria']);
  }

  Future<Pizzeria> pizzeria() async {
    const path = '/owner/pizzeria';
    return Pizzeria.fromJson((await super.get(path: path)).data['pizzeria']);
  }

  Future<List<Item>> menu() async {
    const path = '/owner/menu';

    return ((await super.get(path: path)).data['menu'] as List)
        .map((item) => Item.fromJson(item))
        .toList();
  }

  Future<bool> removeFromMenu(Item item) async {
    const path = '/owner/menu';
    final Map<String, dynamic> parameters = {
      'id': item.id,
    };

    return (await super.delete(path: path, parameters: parameters))
        .data['success'];
  }

  Future<bool> createMenu(List<Item> items) async {
    const path = '/owner/menu';
    final Map<String, dynamic> body = {
      'items': items.map((i) => i.toJsonSimple()).toList(),
    };

    return (await super.post(path: path, body: body)).data['success'];
  }

  Future<Item> addToMenu(Item item) async {
    const path = '/owner/menu';
    final Map<String, dynamic> body = {
      'item': item.toJsonSimple(),
    };

    return Item.fromJson(
        (await super.put(path: path, body: body)).data['item']);
  }

  Future<Item> createItem({
    @required String name,
    @required double price,
    @required ItemType type,
    String image,
  }) async {
    const path = '/owner/item';
    final Map<String, dynamic> body = {
      'name': name,
      'price': price,
      'type': type == ItemType.drink ? 'drink' : 'pizza',
    };

    return Item.fromJson(
        (await super.post(path: path, body: body)).data['item']);
  }

  Future<Item> item({
    @required int id,
  }) async {
    const path = '/owner/item';
    final Map<String, dynamic> parameters = {
      'id': id,
    };
    return Item.fromJson(
        (await super.get(path: path, parameters: parameters)).data['item']);
  }

  Future<bool> editItem({
    @required int id,
    ItemType type,
    double price,
    String name,
  }) async {
    const path = '/owner/item';
    final Map<String, dynamic> parameters = {
      'id': id,
    };
    final Map<String, dynamic> body = {};
    if (type != null)
      body.addAll({
        'type': type == ItemType.drink ? 'drink' : 'pizza',
      });
    if (price != null) body.addAll({'price': price});
    if (name != null) body.addAll({'name': name});

    return (await super.patch(path: path, parameters: parameters, body: body))
        .data['success'];
  }

  Future<List<Opening>> opening() async {
    const path = '/owner/opening';
    return ((await super.get(path: path)).data['openings'] as List)
        .map((o) => Opening.fromJson(o))
        .toList();
  }

  Future<List<Opening>> addOpening({
    @required String start,
    @required String end,
  }) async {
    const path = '/owner/opening';
    final Map<String, dynamic> body = {
      'start': start,
      'end': end,
    };

    return ((await super.put(path: path, body: body)).data['openings'] as List)
        .map((o) => Opening.fromJson(o))
        .toList();
  }

  Future<bool> removeOpening({
    @required int id,
  }) async {
    const path = '/owner/opening';
    final Map<String, dynamic> parameters = {
      'id': id,
    };

    return (await super.delete(path: path, parameters: parameters))
        .data['success'];
  }

  Future<List<Order>> getAllOrders() async {
    const path = '/owner/order';
    return ((await super.get(path: path)).data['orders'] as List)
        .map((o) => Order.fromJson(o))
        .toList();
  }

  Future<bool> editOrder({
    @required int id,
    bool shipped,
    bool delivered,
  }) async {
    const path = '/owner/order';
    final Map<String, dynamic> parameters = {
      'id': id,
    };
    final Map<String, dynamic> body = {};
    if (shipped != null) body.addAll({'shipped': shipped});
    if (delivered != null) body.addAll({'delivered': delivered});

    return (await super.patch(path: path, parameters: parameters, body: body))
        .data['success'];
  }
}
