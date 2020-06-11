import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pizza/models/pizzeria.dart';
import 'package:pizza/models/user.dart';
import 'package:pizza/screens/user/edit_user.dart';
import 'package:pizza/screens/user/user_home.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:pizza/common/custom_search_delegate_impl.dart' as customSearch;

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
                customSearch.showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
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

class CustomSearchDelegate extends customSearch.SearchDelegate {
  List<Pizzeria> pizzerie;

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear, color: AppStyles.kPrimaryColor),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => close(context, null),
    );
  }

  @override
  String get searchFieldLabel => 'Cerca pizzeria...';

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return buildSuggestions(context);
    if (pizzerie == null)
      return Center(
        child: Text("errore"),
      );
    if (pizzerie.isEmpty)
      return Text(
        "Non ci sono pizzerie registrate.",
        style: TextStyle(
          color: AppStyles.kPrimaryColor,
          fontSize: 22,
        ),
      );
    List<Pizzeria> result = pizzerie
        .where((p) => p.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    if (result.isEmpty) {
      return Text(
        "Nessuna pizzeria corrisponde alla ricerca.",
        style: TextStyle(
          color: AppStyles.kPrimaryColor,
          fontSize: 22,
        ),
      );
    }
    return _buildResult(data: result);
  }

  Widget _buildResult({List<Pizzeria> data}) {
    List<Pizzeria> _list = data ?? pizzerie;
    return ListView.builder(
      padding: EdgeInsets.all(kStandardPadding),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _list.length,
      itemBuilder: (context, i) => Container(
        decoration: BoxDecoration(
          color: AppStyles.kBackgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.only(top: kStandardPadding),
        padding: EdgeInsets.all(kStandardPadding / 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_list[i].profilePicture == null)
              Icon(
                Icons.store,
                size: 100,
                color: AppStyles.kPrimaryColor,
              ),
            if (_list[i].profilePicture != null)
              Image.memory(
                base64Decode(
                  String.fromCharCodes(
                    _list[i].profilePicture,
                  ).split("base64,")[1],
                ),
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            Padding(
              padding: EdgeInsets.only(left: kStandardPadding),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _list[i].name,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: AppStyles.kPrimaryColor,
                        ),
                  ),
                  Padding(padding: EdgeInsets.only(top: kStandardPadding / 2)),
                  Text(
                    _list[i].address,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: AppStyles.kPrimaryColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (pizzerie != null) return _buildResult();
    return FutureBuilder<List<Pizzeria>>(
      future: userApi.pizzerie(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Padding(
            padding: const EdgeInsets.all(kStandardPadding),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        if (snapshot.hasError || snapshot.data == null)
          return Center(
            child: Text("errore"),
          );

        List<Pizzeria> data = snapshot.data;
        pizzerie = data;
        if (data.isEmpty)
          return Padding(
            padding: const EdgeInsets.all(kStandardPadding),
            child: Text(
              "Non ci sono pizzerie registrate.",
              style: TextStyle(
                color: AppStyles.kPrimaryColor,
                fontSize: 22,
              ),
            ),
          );

        return _buildResult();
      },
    );
  }
}
