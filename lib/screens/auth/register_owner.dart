import 'package:flutter/material.dart';
import 'package:pizza/common/encode_profile_picture.dart';
import 'package:pizza/common/persist_login_abstract.dart';
import 'package:pizza/common/validate_text.dart';
import 'package:pizza/common/widget/circle_selector_avatar.dart';
import 'package:pizza/common/widget/custom_input_text.dart';
import 'package:pizza/screens/auth/common.dart';
import 'package:pizza/screens/auth/create_pizzeria.dart';
import 'package:pizza/screens/auth/register_user.dart';
import 'package:pizza/services/owner_api.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:provider/provider.dart';

final GlobalKey<FormState> _formKey = GlobalKey();

final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class RegisterOwner extends StatelessWidget {
  static const String kRouteName = 'login/registerOwner';

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
            autovalidate: true,
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
                child: _buildButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildNextButton(
          () {
            error(_) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Registrazione non riuscita"),
                ),
              );
            }

            success(bool result) async {
              if (result) {
                OwnerApi api = OwnerApi();
                String token = await api.login(
                  email: _emailController.text,
                  password: _passwordController.text,
                );

                PersistLogin()
                  ..saveToken(token)
                  ..saveUserType('owner');

                return Navigator.of(context).pushNamed(
                  CreatePizzeria.kRouteName,
                  arguments: api,
                );
              } else
                return Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Proprietario già registrato"),
                  ),
                );
            }

            if (_formKey.currentState.validate()) {
              OwnerApi()
                  .register(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                    profilePicture: Provider.of<ProfilePictureNotifier>(
                      context,
                      listen: false,
                    ).image,
                  )
                  .then(success)
                  .catchError(error);
            }
          },
          "Avanti",
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
          labelText: "First name",
          validator: validateText,
          prefixIcon: Icon(
            Icons.person,
            color: AppStyles.kPrimaryColor,
          ),
        ),
        CustomInputText(
          controller: _lastNameController,
          labelText: "Last name",
          validator: validateText,
          prefixIcon: Icon(
            Icons.person,
            color: AppStyles.kPrimaryColor,
          ),
        ),
        CustomInputText(
          controller: _emailController,
          labelText: "email",
          validator: validateEmail,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icon(
            Icons.email,
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
        "Crea",
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w200,
        ),
      ),
      Text(
        'Account',
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
                              Provider.of<ProfilePictureNotifier>(context,
                                      listen: false)
                                  .image = base64;
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
