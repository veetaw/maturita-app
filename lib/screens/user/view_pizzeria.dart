import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pizza/models/item.dart';
import 'package:pizza/models/pizzeria.dart';
import 'package:pizza/screens/user/user_home.dart';
import 'package:pizza/style/app_styles.dart';

class ViewPizzeria extends StatelessWidget {
  static const String kRouteName = 'userHome/pizzeria';
  final Pizzeria pizzeria;

  const ViewPizzeria({
    @required this.pizzeria,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.kCardColor,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppStyles.kPrimaryColor,
              ),
            ),
            floating: true,
            expandedHeight: MediaQuery.of(context).size.height / 3,
            backgroundColor: Colors.white,
            flexibleSpace: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Stack(
                children: [
                  if (pizzeria.profilePicture == null)
                    Center(
                      child: Icon(
                        Icons.store,
                        size: 100,
                        color: AppStyles.kPrimaryColor,
                      ),
                    ),
                  if (pizzeria.profilePicture != null)
                    Center(
                      child: Image.memory(
                        base64Decode(
                          String.fromCharCodes(
                            pizzeria.profilePicture,
                          ).split("base64,")[1],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: kStandardPadding,
                    left: kStandardPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pizzeria.name,
                          style: TextStyle(
                            color: AppStyles.kPrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 26,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: kStandardPadding / 2,
                          ),
                        ),
                        Text(
                          pizzeria.address,
                          style: TextStyle(
                            color: AppStyles.kPrimaryColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: kStandardPadding,
                    bottom: 0,
                    child: Transform.translate(
                      offset: Offset(0, 25),
                      child: RaisedButton.icon(
                        color: AppStyles.kPrimaryColor,
                        colorBrightness: Brightness.dark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                backgroundColor: AppStyles.kBackgroundColor,
                                title: Text("Informazioni"),
                                titleTextStyle: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: AppStyles.kPrimaryColor,
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      pizzeria.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppStyles.kPrimaryColor,
                                      ),
                                    ),
                                    Text(
                                      pizzeria.address,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppStyles.kPrimaryColor,
                                      ),
                                    ),
                                    Text(
                                      pizzeria.email,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppStyles.kPrimaryColor,
                                      ),
                                    ),
                                    Text(
                                      pizzeria.phone,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppStyles.kPrimaryColor,
                                      ),
                                    ),
                                    Text(
                                      pizzeria.pIva,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppStyles.kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.info_outline),
                        label: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "Informazioni",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(kStandardPadding),
                  child: Text(
                    "Menù:",
                    style: TextStyle(
                      fontSize: 30,
                      color: AppStyles.kPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Content(pizzeria: pizzeria),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}

class Content extends StatelessWidget {
  final Pizzeria pizzeria;

  const Content({
    @required this.pizzeria,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: kStandardPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(kStandardPadding),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    color: AppStyles.kPrimaryColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kStandardPadding,
                    ),
                    child: Text(
                      "Filtra per categoria",
                      style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: kStandardPadding,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: kStandardPadding),
                    child: _FilterCategoryIndicator(
                      title: "Pizze",
                      icon: Icons.local_pizza,
                    ),
                  ),
                  _FilterCategoryIndicator(
                    title: "Bevande",
                    icon: Icons.local_drink,
                  ),
                ],
              )
            ],
          ),
        ),
        FutureBuilder<Pizzeria>(
          future: userApi.pizzeria(id: pizzeria.id),
          builder: (context, snapshot) {
            Pizzeria data = snapshot.data;
            if (snapshot.connectionState != ConnectionState.done)
              return Padding(
                padding: const EdgeInsets.all(kStandardPadding),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            if (snapshot.hasError || data == null)
              return Center(
                child: Text("errore nel caricamento del menù."),
              );
            if (data.menu == null || data.menu.isEmpty)
              return Center(
                child: Text(
                  "La pizzeria non ha un menù associato.",
                  style: TextStyle(
                    color: AppStyles.kPrimaryColor,
                    fontSize: 18,
                  ),
                ),
              );
            return Column(
              children: data.menu.map((i) => ItemContainer(item: i)).toList(),
            );
          },
        ),
      ],
    );
  }
}

class ItemContainer extends StatelessWidget {
  const ItemContainer({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: kStandardPadding,
        right: kStandardPadding,
        bottom: kStandardPadding,
      ),
      decoration: BoxDecoration(
        color: AppStyles.kBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width,
      height: 120,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(kStandardPadding),
            child: Icon(
              item.type == ItemType.drink
                  ? Icons.local_drink
                  : Icons.local_pizza,
              size: 68,
              color: AppStyles.kPrimaryColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  color: AppStyles.kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              Text(
                item.price.toStringAsFixed(2) + " €",
                style: TextStyle(
                  color: AppStyles.kPrimaryColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
              RaisedButton.icon(
                color: AppStyles.kPrimaryColor,
                colorBrightness: Brightness.dark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.add_shopping_cart,
                ),
                label: Text("Aggiungi al carrello"),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterCategoryIndicator extends StatelessWidget {
  final String title;
  final IconData icon;
  const _FilterCategoryIndicator({
    @required this.title,
    @required this.icon,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppStyles.kCardColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: AppStyles.kPrimaryColor,
          ),
          Text(
            title,
            style: TextStyle(
              color: AppStyles.kPrimaryColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
