import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pizza/common/widget/circle_selector_avatar.dart';
import 'package:pizza/common/widget/custom_switch.dart';
import 'package:pizza/models/item.dart';
import 'package:pizza/screens/auth/common.dart';
import 'package:pizza/screens/owner/owner_home.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:provider/provider.dart';

class CreateMenu extends StatelessWidget {
  static const String kRouteName =
      'login/registerOwner/createPizzeria/createOpenings/createMenu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.kBackgroundColor,
      body: SafeArea(
        child: ChangeNotifierProvider<MenuNotifier>(
          create: (_) => MenuNotifier(),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: constraints.maxHeight > constraints.maxWidth
                    ? _buildPortrait(constraints, context)
                    : _buildLandscape(constraints, context),
              );
            },
          ),
        ),
      ),
    );
  }

  Container _buildPortrait(BoxConstraints constraints, BuildContext context) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _buildTitle(),
          ),
          Expanded(
            flex: 6,
            child: _buildItems(constraints, context),
          ),
          Expanded(
            flex: 2,
            child: _buildButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildItems(BoxConstraints constraints, BuildContext context) {
    List<Item> items = Provider.of<MenuNotifier>(context).items;
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: kStandardPadding,
      ),
      physics: BouncingScrollPhysics(),
      children: [
        if (items == null || items.isEmpty) ...[
          Text(
            "Attualmente non hai aggiunto prodotti",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: constraints.maxWidth / 2,
              padding: EdgeInsets.only(top: kStandardPadding),
              child: MaterialButton(
                height: 50,
                onPressed: () {
                  showDialog(
                    context: context,
                    child: CustomDialog(
                      constraints: constraints,
                    ),
                  );
                },
                color: AppStyles.kPrimaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "Aggiungi prodotto",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        for (Item item in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kStandardPadding),
            child: Container(
              decoration: BoxDecoration(
                color: AppStyles.kCardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  if (item.image == null)
                    Icon(
                      item.type == ItemType.drink
                          ? Icons.local_drink
                          : Icons.local_pizza,
                    ),
                  if (item.image != null)
                    Image.memory(
                      Uint8List.fromList(item.image),
                    )
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kStandardPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildTitle('Crea', 'Menù'),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kStandardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildNextButton(
            () {
              // TODO: check if owner added at least one item
            Navigator.of(context).pushNamedAndRemoveUntil(
              OwnerHome.kRouteName,
              (_) => false,
            );
            },
            "Fine",
          ),
        ],
      ),
    );
  }

  Widget _buildLandscape(BoxConstraints constraints, BuildContext context) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTitle(),
                _buildButton(context),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildItems(constraints, context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final BoxConstraints constraints;

  const CustomDialog({
    Key key,
    @required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppStyles.kBackgroundColor,
        title: Text("Dati prodotto"),
        content: Container(
          constraints: BoxConstraints(
            maxHeight: constraints.maxHeight / 3,
            minWidth: constraints.maxHeight > constraints.maxWidth
                ? constraints.maxWidth
                : constraints.maxWidth / 2,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleSelectorAvatar(onTap: () {}),
                    Column(
                      children: [
                        Container(
                          width: constraints.maxWidth / 3,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Nome',
                              labelStyle: TextStyle(
                                color: AppStyles.kPrimaryColor,
                              ),
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          width: constraints.maxWidth / 3,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Prezzo',
                              labelStyle: TextStyle(
                                color: AppStyles.kPrimaryColor,
                              ),
                              suffixText: "€",
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: kStandardPadding,
                  ),
                  child: CustomSwitch(
                    titles: ['Pizza', 'Drink'],
                    constraints: constraints,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Center(
              child: Text("Annulla"),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Center(
              child: Text("Aggiungi"),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuNotifier extends ChangeNotifier {
  List<Item> _items = [];

  addItem(Item item) {
    _items.add(item);

    notifyListeners();
  }

  removeItem(Item item) {
    _items.remove(item);

    notifyListeners();
  }

  get items => _items;
}
