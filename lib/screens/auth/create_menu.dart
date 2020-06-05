import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pizza/common/encode_profile_picture.dart';
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
    final double paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppStyles.kBackgroundColor,
      body: SafeArea(
        child: ChangeNotifierProvider<MenuNotifier>(
          create: (_) => MenuNotifier(),
          child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: orientation == Orientation.portrait
                    ? _buildPortrait(context, paddingTop)
                    : _buildLandscape(context, paddingTop),
              );
            },
          ),
        ),
      ),
    );
  }

  Container _buildPortrait(BuildContext context, double paddingTop) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height - paddingTop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _buildTitle(),
          ),
          Expanded(
            flex: 6,
            child: _buildItems(context),
          ),
          Expanded(
            flex: 2,
            child: _buildButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    List<Item> items = Provider.of<MenuNotifier>(context).items;
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: kStandardPadding,
      ),
      physics: BouncingScrollPhysics(),
      children: [
        if (items == null || items.isEmpty)
          Text(
            "Attualmente non hai aggiunto prodotti",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        for (Item item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: kStandardPadding),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppStyles.kCardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: kStandardPadding,
                        vertical: kStandardPadding / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: AppStyles.kPrimaryColor,
                              ),
                        ),
                        Text(
                          item.price.toString() + '€',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: AppStyles.kPrimaryColor,
                              ),
                        ),
                        Text(
                          item.type == ItemType.drink ? 'Bevanda' : 'Pizza',
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
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            padding: EdgeInsets.only(top: kStandardPadding),
            child: MaterialButton(
              height: 50,
              onPressed: () {
                showDialog(
                  context: context,
                  child: CustomDialog(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                      maxWidth: MediaQuery.of(context).size.width,
                    ),
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

  Widget _buildLandscape(BuildContext context, double paddingTop) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height - paddingTop,
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
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: kStandardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildItems(context),
                ],
              ),
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
  String image;
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
                      CircleSelectorAvatar(
                        image: image != null
                            ? CircleAvatar(
                                backgroundImage:
                                    MemoryImage(base64Decode(image)),
                                radius: 100,
                              )
                            : null,
                        onTap: () async {
                          String base64 = await encodeProfilePicture();
                          if (base64 != null) setState(() => image = base64);
                        },
                      ),
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
                  image: image,
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
