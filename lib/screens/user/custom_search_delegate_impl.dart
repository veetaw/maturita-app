import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pizza/models/pizzeria.dart';
import 'package:pizza/common/custom_search_delegate.dart' as customSearch;
import 'package:pizza/screens/user/user_home.dart';
import 'package:pizza/style/app_styles.dart';

class CustomSearchDelegate<T extends Pizzeria>
    extends customSearch.SearchDelegate<T> {
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
      padding: EdgeInsets.only(
        bottom: kStandardPadding,
        left: kStandardPadding,
        right: kStandardPadding,
      ),
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
        child: InkWell(
          onTap: () {
            close(context, _list[i]);
          },
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
                    Padding(
                        padding: EdgeInsets.only(top: kStandardPadding / 2)),
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
