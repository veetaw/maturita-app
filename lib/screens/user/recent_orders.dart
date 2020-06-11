import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pizza/models/item.dart';
import 'package:pizza/models/order.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:pizza/services/user_api.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:provider/provider.dart';

class RecentOrders extends StatefulWidget {
  final UserApi api;
  const RecentOrders({
    @required this.api,
    Key key,
  }) : super(key: key);

  @override
  _RecentOrdersState createState() => _RecentOrdersState();
}

class _RecentOrdersState extends State<RecentOrders> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kStandardPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(kStandardPadding),
      child: InkWell(
        onTap: () => setState(() => expanded = !expanded),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: kStandardPadding,
                  ),
                  child: Icon(
                    Icons.fastfood,
                    color: AppStyles.kPrimaryColor,
                  ),
                ),
                Text(
                  "Ordini recenti",
                  style: TextStyle(
                    color: AppStyles.kPrimaryColor,
                    fontSize: 22,
                  ),
                )
              ],
            ),
            FutureProvider<List<Order>>(
              create: (_) => widget.api.orders(),
              child: Consumer<List<Order>>(
                builder: (context, orders, _) {
                  if (orders == null)
                    return Center(child: CircularProgressIndicator());
                  if (orders.isEmpty)
                    return Padding(
                      padding: EdgeInsets.only(top: kStandardPadding),
                      child: Text(
                        "Non hai effettuato ordini",
                        style: TextStyle(
                          color: AppStyles.kPrimaryColor,
                          fontSize: 22,
                        ),
                      ),
                    );
                  if (!expanded) {
                    Order lastOrder = orders.last;
                    Item lastItem = lastOrder.items.last;
                    return OrderCard(item: lastItem, order: lastOrder);
                  } else {
                    orders = orders.reversed.toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: orders.length,
                      itemBuilder: (context, i) => OrderCard(
                          order: orders[i], item: orders[i].items.last),
                    );
                  }
                },
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: kStandardPadding / 2),
                width: MediaQuery.of(context).size.width / 8,
                height: 6,
                decoration: BoxDecoration(
                  color: AppStyles.kCardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key key,
    @required this.item,
    @required this.order,
  }) : super(key: key);

  final Item item;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyles.kBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.only(top: kStandardPadding),
      padding: EdgeInsets.all(kStandardPadding / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.image == null)
            Icon(
              item.type == ItemType.drink
                  ? Icons.local_drink
                  : Icons.local_pizza,
              size: 100,
              color: AppStyles.kPrimaryColor,
            ),
          if (item.image != null)
            Image.memory(
              base64Decode(
                String.fromCharCodes(
                  item.image,
                ).split("base64,")[1],
              ),
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
          Padding(
            padding: EdgeInsets.only(left: kStandardPadding),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.name,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: AppStyles.kPrimaryColor,
                    ),
              ),
              Padding(padding: EdgeInsets.only(top: kStandardPadding / 4)),
              Text(
                order.total.toString() + ' € (totale)',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: AppStyles.kPrimaryColor,
                    ),
              ),
              Padding(padding: EdgeInsets.only(top: kStandardPadding / 4)),
              Text(
                timeago.format(order.start),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: AppStyles.kPrimaryColor,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
