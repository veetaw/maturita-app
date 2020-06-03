import 'package:flutter/material.dart';
import 'package:pizza/common/encode_profile_picture.dart';
import 'package:pizza/common/validate_text.dart';
import 'package:pizza/common/widget/circle_selector_avatar.dart';
import 'package:pizza/common/widget/custom_input_text.dart';
import 'package:pizza/screens/auth/auth.dart';
import 'package:pizza/screens/auth/common.dart';
import 'package:pizza/services/owner_api.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:provider/provider.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _pIvaController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _addressController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();

class CreatePizzeria extends StatelessWidget {
  final OwnerApi api;
  static const String kRouteName = 'login/registerOwner/createPizzeria';

  const CreatePizzeria({Key key, @required this.api}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppStyles.kBackgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ChangeNotifierProvider<ProfilePictureNotifier>(
          create: (_) => ProfilePictureNotifier(),
          child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              return orientation == Orientation.portrait
                  ? _buildPortrait(context, paddingTop)
                  : _buildLandscape(context, paddingTop);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPortrait(BuildContext context, double paddingTop) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: size.width,
        height: size.height - paddingTop,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kStandardPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildTitle(),
                    ),
                    CircleSelectorAvatar(
                      image: getCircleImage(context),
                      onTap: () async {
                        String base64 = await encodeProfilePicture();
                        if (base64 != null)
                          Provider.of<ProfilePictureNotifier>(context,
                                  listen: false)
                              .image = base64;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kStandardPadding),
                child: _buildFields(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kStandardPadding),
                child: _buildButton(context, api),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildButton(BuildContext context, OwnerApi api) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildNextButton(() {
          success(_) {
            Navigator.of(context).pushNamed(
              CreateOpenings.kRouteName,
              arguments: api,
            );
          }

          error(_) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Impossibile creare pizzeria"),
              ),
            );
          }

          api
              .createPizzeria(
                name: _nameController.text,
                pIva: _pIvaController.text,
                address: _addressController.text,
                phone: _phoneController.text,
                email: _emailController.text,
                profilePicture: Provider.of<ProfilePictureNotifier>(
                  context,
                  listen: false,
                ).image,
              )
              .then(success)
              .catchError(error);
        }, "Avanti"),
      ],
    );
  }

  Form _buildFields() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomInputText(
            labelText: "Name",
            validator: validateText,
            controller: _nameController,
            prefixIcon: Icon(
              Icons.person,
              color: AppStyles.kPrimaryColor,
            ),
          ),
          CustomInputText(
            labelText: "P.IVA",
            validator: (text) =>
                text.length != 11 ? 'Partita Iva non valida' : null,
            controller: _pIvaController,
            prefixIcon: Icon(
              Icons.business,
              color: AppStyles.kPrimaryColor,
            ),
          ),
          CustomInputText(
            labelText: "address",
            validator: validateText,
            controller: _addressController,
            prefixIcon: Icon(
              Icons.home,
              color: AppStyles.kPrimaryColor,
            ),
          ),
          CustomInputText(
            labelText: "phone",
            validator: validateText,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            prefixIcon: Icon(
              Icons.phone,
              color: AppStyles.kPrimaryColor,
            ),
          ),
          CustomInputText(
            controller: _emailController,
            validator: validateEmail,
            labelText: "email",
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(
              Icons.email,
              color: AppStyles.kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTitle() {
    return [
      Text(
        'Dati',
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w200,
        ),
      ),
      Text(
        'Pizzeria',
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w600,
        ),
      ),
    ];
  }

  Widget _buildLandscape(BuildContext context, double paddingTop) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: size.width,
        height: size.height - paddingTop,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kStandardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: buildTitle('Dati', 'Pizzeria'),
                        ),
                        CircleSelectorAvatar(
                          image: getCircleImage(context),
                          onTap: () async {
                            String base64 = await encodeProfilePicture();
                            if (base64 != null)
                              Provider.of<ProfilePictureNotifier>(context,
                                      listen: false)
                                  .image = base64;
                          },
                        ),
                      ],
                    ),
                    _buildButton(context, api),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: _buildFields(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
