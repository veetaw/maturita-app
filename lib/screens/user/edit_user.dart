import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pizza/common/encode_profile_picture.dart';
import 'package:pizza/common/validate_text.dart';
import 'package:pizza/common/widget/circle_selector_avatar.dart';
import 'package:pizza/common/widget/custom_input_text.dart';
import 'package:pizza/screens/auth/common.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:provider/provider.dart';

final GlobalKey<FormState> _formKey = GlobalKey();

final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _addressController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class EditUser extends StatelessWidget {
  static const String kRouteName = "userHome/edit";

  @override
  Widget build(BuildContext context) {
    final double paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppStyles.kBackgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ChangeNotifierProvider<ProfilePictureNotifier>(
          create: (_) => ProfilePictureNotifier(),
          child: Form(
            key: _formKey,
            autovalidate: false,
            child: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                return orientation == Orientation.portrait
                    ? _buildPortrait(context, paddingTop)
                    : _buildLandscape(context, paddingTop);
              },
            ),
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
                          Provider.of<ProfilePictureNotifier>(
                            context,
                            listen: false,
                          ).image = base64;
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
                child: _buildButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildNextButton(
          () async {
            _formKey.currentState.validate();
            await Future.delayed(Duration(seconds: 1));
            Navigator.of(context).pop();
          },
          "Modifica",
        ),
      ],
    );
  }

  Widget _buildFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomInputText(
          controller: _firstNameController,
          labelText: "Nome",
          prefixIcon: Icon(
            Icons.person,
            color: AppStyles.kPrimaryColor,
          ),
        ),
        CustomInputText(
          controller: _lastNameController,
          labelText: "Cognome",
          prefixIcon: Icon(
            Icons.person,
            color: AppStyles.kPrimaryColor,
          ),
        ),
        CustomInputText(
          controller: _emailController,
          labelText: "Email",
          validator: validateEmail,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icon(
            Icons.email,
            color: AppStyles.kPrimaryColor,
          ),
        ),
        CustomInputText(
          controller: _addressController,
          labelText: "Indirizzo",
          prefixIcon: Icon(
            Icons.home,
            color: AppStyles.kPrimaryColor,
          ),
        ),
        CustomInputText(
          controller: _phoneController,
          labelText: "Telefono",
          keyboardType: TextInputType.phone,
          prefixIcon: Icon(
            Icons.phone,
            color: AppStyles.kPrimaryColor,
          ),
        ),
        PasswordInputText(
          controller: _passwordController,
        ),
      ],
    );
  }

  List<Widget> _buildTitle() {
    return [
      Text(
        "Modifica",
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w200,
        ),
      ),
      Text(
        'Dati',
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
                          children: buildTitle('Crea', 'Account'),
                        ),
                        CircleSelectorAvatar(
                          image: getCircleImage(context),
                          onTap: () async {
                            String base64 = await encodeProfilePicture();
                            if (base64 != null)
                              Provider.of<ProfilePictureNotifier>(
                                context,
                                listen: false,
                              ).image = base64;
                          },
                        ),
                      ],
                    ),
                    _buildButton(context),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                primary: true,
                physics: BouncingScrollPhysics(),
                child: _buildFields(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePictureNotifier extends ChangeNotifier {
  String _image;
  set image(String newImage) {
    _image = newImage;

    notifyListeners();
  }

  get image => _image;
}

Widget getCircleImage(context) {
  String image = Provider.of<ProfilePictureNotifier>(
    context,
  ).image;
  if (image == null) return null;
  return CircleAvatar(
    backgroundImage: MemoryImage(base64Decode(image)),
    radius: 100,
  );
}
