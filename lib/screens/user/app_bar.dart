import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pizza/models/pizzeria.dart';
import 'package:pizza/models/user.dart';
import 'package:pizza/screens/user/custom_search_delegate_impl.dart';
import 'package:pizza/screens/user/edit_user.dart';
import 'package:pizza/screens/user/view_pizzeria.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:pizza/common/custom_search_delegate.dart' as customSearch;

class CustomAppBar extends StatefulWidget {
  final User user;
  final BoxConstraints constraints;

  const CustomAppBar({
    @required this.constraints,
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    String rawImage = String.fromCharCodes(
      widget.user.profilePicture,
    );
    String image = rawImage.split("base64,").length == 1
        ? rawImage
        : rawImage.split("base64,")[1];

    return InkWell(
      onTap: () => setState(() => expanded = !expanded),
      child: Container(
        width: widget.constraints.maxWidth,
        padding: EdgeInsets.all(kStandardPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                customSearch
                    .showSearch<Pizzeria>(
                  context: context,
                  delegate: CustomSearchDelegate<Pizzeria>(),
                )
                    .then((value) {
                  if (value != null) {
                    Navigator.of(context).pushNamed(
                      ViewPizzeria.kRouteName,
                      arguments: value,
                    );
                  }
                });
              },
              child: Container(
                width: widget.constraints.maxWidth - (kStandardPadding * 2),
                padding: EdgeInsets.symmetric(vertical: kStandardPadding / 2),
                decoration: BoxDecoration(
                  color: AppStyles.kDividerColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kStandardPadding / 2,
                      ),
                      child: Icon(
                        Icons.search,
                        color: AppStyles.kPrimaryColor,
                      ),
                    ),
                    Text(
                      "Cerca pizzeria...",
                      style: TextStyle(
                        color: AppStyles.kPrimaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: kStandardPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.navigation,
                        color: AppStyles.kPrimaryColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: kStandardPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Spedisci a:",
                              style: TextStyle(
                                color: AppStyles.kPrimaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 4)),
                            Text(
                              "${widget.user.firstName} ${widget.user.lastName}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            if (expanded) ...[
                              Text(
                                widget.user.address,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                widget.user.phone,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!expanded)
                    InkWell(
                      onTap: () =>
                          Navigator.of(context).pushNamed(EditUser.kRouteName),
                      child: Icon(
                        Icons.edit,
                        color: AppStyles.kPrimaryColor,
                      ),
                    ),
                  if (expanded)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: widget.user.profilePicture != null
                              ? MemoryImage(
                                  base64Decode(
                                    image,
                                  ),
                                )
                              : null,
                          backgroundColor: AppStyles.kBackgroundColor,
                        ),
                        RaisedButton.icon(
                          color: AppStyles.kPrimaryColor,
                          colorBrightness: Brightness.dark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(EditUser.kRouteName),
                          icon: Icon(Icons.edit),
                          label: Text("Modifica"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: widget.constraints.maxWidth / 8,
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
