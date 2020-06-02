import 'package:flutter/material.dart';
import 'package:pizza/common/validate_text.dart';
import 'package:pizza/common/widget/circle_selector_avatar.dart';
import 'package:pizza/common/widget/custom_input_text.dart';
import 'package:pizza/screens/auth/common.dart';
import 'package:pizza/screens/user/user_home.dart';
import 'package:pizza/services/user_api.dart';
import 'package:pizza/style/app_styles.dart';

final GlobalKey<FormState> _formKey = GlobalKey();

final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _addressController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class RegisterUser extends StatelessWidget {
  static const String kRouteName = 'login/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.kBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxHeight > constraints.maxWidth)
                return _buildPortrait(context, constraints);
              else
                return _buildLandscape(context, constraints);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPortrait(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
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
                    CircleSelectorAvatar(onTap: () {}),
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
          () {
            error(_) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Registrazione non riuscita"),
                ),
              );
            }

            success(bool result) {
              if (result)
                return Navigator.of(context).pushNamedAndRemoveUntil(
                  UserHome.kRouteName,
                  (_) => false,
                );
              else
                return Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Utente già registrato"),
                  ),
                );
            }

            if (_formKey.currentState.validate()) {
              UserApi()
                  .register(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                    address: _addressController.text,
                    phone: _phoneController.text,
                    password: _passwordController.text,
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
        CustomInputText(
          controller: _addressController,
          labelText: "address",
          validator: validateText,
          prefixIcon: Icon(
            Icons.home,
            color: AppStyles.kPrimaryColor,
          ),
        ),
        CustomInputText(
          controller: _phoneController,
          labelText: "phone",
          validator: validateText,
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

  Widget _buildLandscape(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
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
                        CircleSelectorAvatar(onTap: () {}),
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
