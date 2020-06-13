import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pizza/models/pizzeria.dart';
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
                        onPressed: () {},
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
                Content(),
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
          child: Row(
            children: [
              Icon(
                Icons.filter_list,
                color: AppStyles.kPrimaryColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kStandardPadding),
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
        ),
      ],
    );
  }
}
