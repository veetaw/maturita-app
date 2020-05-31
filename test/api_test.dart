import 'dart:math';

import 'package:test/test.dart';
import 'package:pizza/models/item.dart';
import 'package:pizza/models/order.dart';
import 'package:pizza/models/pizzeria.dart';
import 'package:pizza/models/user.dart';
import 'package:pizza/services/user_api.dart';

main() {
  group('User API', () {
    UserApi api;
    setUpAll(() {
      api = UserApi();
    });

    test('Register user', () async {
      bool result = await api.register(
        firstName: "Test",
        lastName: "User",
        email: "test." + Random().nextInt(1000).toString() + "@email.com",
        address: "Null street, 222",
        phone: "+16666666666",
        password: "testpassword",
      );

      expect(result, isTrue);
    }, skip: true);
    String token;
    test('Login user', () async {
      token = await api.login(
        email: "test@email.com",
        password: "testpassword",
      );

      expect(token, isNotNull);
      expect(token, isNotEmpty);
    });

    test('Get user info', () async {
      User user = await api.info();

      expect(user, isNotNull);
      expect(user.firstName, equals("Test"));
      expect(user.lastName, equals("User"));
      expect(user.email, equals("test@email.com"));
      expect(user.address, equals("Null street, 222"));
      expect(user.phone, equals("+16666666666"));
    });

    test('Get all pizzerie', () async {
      List<Pizzeria> pizzerie = await api.pizzerie();

      expect(pizzerie, isNotEmpty);
    });

    test('Get pizzeria', () async {
      Pizzeria pizzeria = await api.pizzeria(id: 1);

      expect(pizzeria, isNotNull);
    });

    Order order;
    test('Create order', () async {
      order = await api.createOrder(
        pizzeria: Pizzeria(id: 1),
        items: [Item(id: 2)],
      );

      expect(order, isNotNull);
    });

    test('Get all orders', () async {
      List<Order> orders = await api.orders();

      expect(orders, isNotEmpty);
    });

    test('Get order', () async {
      Order _order = await api.order(
        id: order.id,
      );

      expect(_order, isNotNull);
      expect(_order.id, equals(order.id));
    });
  });
}
