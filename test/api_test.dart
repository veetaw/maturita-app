import 'dart:math';

import 'package:pizza/models/opening.dart';
import 'package:pizza/models/owner.dart';
import 'package:pizza/services/owner_api.dart';
import 'package:test/test.dart';
import 'package:pizza/models/item.dart';
import 'package:pizza/models/order.dart';
import 'package:pizza/models/pizzeria.dart';
import 'package:pizza/models/user.dart';
import 'package:pizza/services/user_api.dart';

main() {
  group('User API', () {
    UserApi api = UserApi();
    setUpAll(() async {
      try {
        await api.register(
          firstName: "Test",
          lastName: "User",
          email: "test@email.com",
          address: "Null street, 222",
          phone: "+16666666666",
          password: "testpassword",
        );
      } on Exception catch (_) {}
    });

    test('Login user', () async {
      String token = await api.login(
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
  group('Owner API', () {
    OwnerApi api = OwnerApi();

    setUpAll(() async {
      try {
        await api.register(
          firstName: "Test",
          lastName: "Owner",
          email: "email@provider.com",
          password: "testpassword",
        );
      } catch (_) {}

      try {
        await api.createPizzeria(
          name: "Pizzeria",
          pIva: "asd",
          address: "asd",
          phone: "asd",
          email: "email@provider.com",
        );
      } catch (_) {}
    });

    test('Login owner', () async {
      String token = await api.login(
        email: "email@provider.com",
        password: "testpassword",
      );
      expect(token, isNotNull);
      expect(token, isNotEmpty);
    });

    test('Get owner Info', () async {
      Owner owner = await api.info();

      expect(owner.firstName, equals("Test"));
      expect(owner.lastName, equals("Owner"));
      expect(owner.email, equals("email@provider.com"));
    });

    Pizzeria pizzeria;
    test('Get pizzeria', () async {
      pizzeria = await api.pizzeria();

      expect(pizzeria, isNotNull);
      expect(pizzeria.name, equals("Pizzeria"));
      expect(pizzeria.pIva, equals("asd"));
      expect(pizzeria.address, equals("asd"));
      expect(pizzeria.phone, equals("asd"));
      expect(pizzeria.email, equals("email@provider.com"));
    });
    Item item;
    Item item2;
    test('Create item', () async {
      item = await api.createItem(
        name: "pizza",
        price: 2.5,
        type: ItemType.pizza,
      );

      item2 = await api.createItem(
        name: "water",
        price: 2.5,
        type: ItemType.drink,
      );

      expect(item, isNotNull);
      expect(item.name, equals("pizza"));
      expect(item.price, equals(2.5));
      expect(item.type, equals(ItemType.pizza));
    });
    test('Edit item', () async {
      bool result = await api.editItem(
        id: item.id,
        price: 3.5,
      );

      expect(result, isNotNull);
      expect(result, isTrue);
    });

    test('Get item', () async {
      Item _item = await api.item(id: item.id);

      expect(_item, isNotNull);
      expect(_item.name, equals(item.name));
      expect(_item.price, equals(3.5));
      expect(_item.type, equals(item.type));
    });

    test('Create Menu', () async {
      bool result = await api.createMenu([item]);

      expect(result, isNotNull);
      expect(result, isTrue);
    });

    test('Add to menu', () async {
      Item _item = await api.addToMenu(item2);

      expect(_item, isNotNull);
      expect(_item.name, equals("water"));
      expect(_item.price, equals(2.5));
      expect(_item.type, equals(ItemType.drink));
    });

    test('Get menu', () async {
      List<Item> items = await api.menu();

      expect(items, isNotNull);
      expect(items, isNotEmpty);
      Item _item = items.firstWhere((i) => i.id == item.id);
      expect(_item.name, equals(item.name));
      expect(_item.price, equals(3.5));
      expect(_item.type, equals(item.type));
    });

    test('Remove from Menu', () async {
      bool result = await api.removeFromMenu(item2);

      expect(result, isNotNull);
      expect(result, isTrue);
    });

    Opening opening;
    test('Add opening', () async {
      List<Opening> openings = await api.addOpening(
        start: "11:30",
        end: "13:30",
      );

      opening = openings.last;
      expect(opening, isNotNull);
      expect(opening.start, "11:30");
      expect(opening.end, "13:30");
    });

    test('Get all openings', () async {
      List<Opening> openings = await api.opening();

      Opening _opening = openings.firstWhere((o) => o.id == opening.id);
      expect(_opening, isNotNull);
      expect(_opening.start, opening.start);
      expect(_opening.end, opening.end);
    });

    test('Remove opening', () async {
      bool result = await api.removeOpening(
        id: opening.id,
      );

      expect(result, isNotNull);
      expect(result, isTrue);
    });

    Order order;
    test('Get all orders', () async {
      UserApi userApi = UserApi();

      await userApi.login(
        email: "email@provider.com",
        password: "testpassword",
      );

      Order _userOrder =
          await userApi.createOrder(pizzeria: pizzeria, items: [item]);

      List<Order> orders = await api.getAllOrders();

      order = orders.firstWhere((o) => o.id == _userOrder.id);

      expect(order, isNotNull);
      expect(order.total, equals(2.5));
    }, skip: true);

    test('Edit order', () async {
      bool result = await api.editOrder(
        id: order.id,
        shipped: true,
      );

      expect(result, isTrue);
    }, skip: true);
  });
}
