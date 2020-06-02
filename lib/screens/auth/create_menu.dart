import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pizza/common/validate_text.dart';
import 'package:pizza/common/widget/circle_selector_avatar.dart';
import 'package:pizza/common/widget/custom_switch.dart';
import 'package:pizza/models/item.dart';
import 'package:pizza/screens/auth/common.dart';
import 'package:pizza/screens/owner/owner_home.dart';
import 'package:pizza/services/owner_api.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:provider/provider.dart';

class CreateMenu extends StatelessWidget {
  final OwnerApi api;
  static const String kRouteName =
      'login/registerOwner/createPizzeria/createOpenings/createMenu';

  const CreateMenu({Key key, @required this.api}) : super(key: key);

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
                      api: api,
                      context: context,
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

class CustomDialog extends StatefulWidget {
  final BoxConstraints constraints;
  final OwnerApi api;
  final BuildContext context;

  const CustomDialog({
    Key key,
    @required this.constraints,
    @required this.api,
    @required this.context,
  }) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String itemType = 'pizza';
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final List<String> items = ['Pizza', 'Drink'];

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
            maxHeight: widget.constraints.maxHeight / 3,
            minWidth: widget.constraints.maxHeight > widget.constraints.maxWidth
                ? widget.constraints.maxWidth
                : widget.constraints.maxWidth / 2,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
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
                            width: widget.constraints.maxWidth / 3,
                            child: TextFormField(
                              controller: _itemNameController,
                              validator: validateText,
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
                            width: widget.constraints.maxWidth / 3,
                            child: TextFormField(
                              controller: _itemPriceController,
                              keyboardType: TextInputType.number,
                              validator: (text) => text.length < 1 ||
                                      double.tryParse(text) == null
                                  ? "non valido"
                                  : null,
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
                      titles: items,
                      tapCallback: (i) => setState(() => itemType = items[i]),
                      constraints: widget.constraints,
                    ),
                  ),
                ],
              ),
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
            onPressed: () async {
              if (_formKey.currentState.validate() &&
                  double.tryParse(_itemPriceController.text) != null) {
                Item item = await widget.api.createItem(
                  name: _itemNameController.text,
                  price: double.parse(_itemPriceController.text),
                  type: fromString(itemType.toLowerCase()),
                );

                await widget.api.addToMenu(item);

                Provider.of<MenuNotifier>(widget.context, listen: false)
                    .addItem(item);
                Navigator.of(context).pop();
              }
            },
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
