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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(kStandardPadding),
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
                Order lastOrder = orders.first;
                Item lastItem = lastOrder.items.first;
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
                      if (lastItem.image == null)
                        Icon(
                          lastItem.type == ItemType.drink
                              ? Icons.local_drink
                              : Icons.local_pizza,
                          size: 100,
                          color: AppStyles.kPrimaryColor,
                        ),
                      if (lastItem.image != null)
                        Image.memory(
                          base64Decode(
                            String.fromCharCodes(
                              lastItem.image,
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
                            lastItem.name,
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      color: AppStyles.kPrimaryColor,
                                    ),
                          ),
                          Text(
                            lastItem.price.toString() + '€',
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: AppStyles.kPrimaryColor,
                                    ),
                          ),
                          Text(
                            timeago.format(lastOrder.start),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: AppStyles.kPrimaryColor,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
