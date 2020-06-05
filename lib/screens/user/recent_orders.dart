import 'package:flutter/material.dart';
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
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
