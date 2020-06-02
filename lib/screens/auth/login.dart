import 'package:flutter/material.dart';
import 'package:pizza/common/persist_login_abstract.dart';
import 'package:pizza/common/validate_email.dart';
import 'package:pizza/common/widget/custom_input_text.dart';
import 'package:pizza/common/widget/custom_switch.dart';
import 'package:pizza/screens/auth/common.dart';
import 'package:pizza/screens/auth/register_owner.dart';
import 'package:pizza/screens/auth/register_user.dart';
import 'package:pizza/screens/owner/owner_home.dart';
import 'package:pizza/screens/user/user_home.dart';
import 'package:pizza/services/owner_api.dart';
import 'package:pizza/services/user_api.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:provider/provider.dart';

final GlobalKey<FormState> formKey = GlobalKey();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class Login extends StatelessWidget {
  static const String kRouteName = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.kBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ChangeNotifierProvider<SwitchNotifier>(
          create: (_) => SwitchNotifier(),
          child: Form(
            key: formKey,
            autovalidate: true,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxHeight > constraints.maxWidth)
                  return _buildPortrait(context, constraints);
                else
                  return _buildLandscape(context, constraints);
              },
            ),
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
                padding: const EdgeInsets.only(left: kStandardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buildTitle(
                    'Login',
                    Provider.of<SwitchNotifier>(context).activeIndex == 0
                        ? 'Utente'
                        : 'Proprietario',
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kStandardPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buildInputTexts(),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kStandardPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buildButtons(context, constraints),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildButtons(BuildContext context, BoxConstraints constraints) {
    int activeIndex = Provider.of<SwitchNotifier>(
      context,
      listen: false,
    ).activeIndex;
    return [
      CustomSwitch(
        constraints: constraints,
        tapCallback: (i) =>
            Provider.of<SwitchNotifier>(context, listen: false).activeIndex = i,
      ),
      buildNextButton(() {
        if (activeIndex == 0)
          Navigator.of(context).pushNamed(RegisterUser.kRouteName);
        else
          Navigator.of(context).pushNamed(RegisterOwner.kRouteName);
      }, "Registrati"),
      buildNextButton(() {
        error(_) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Login non riuscito"),
            ),
          );
        }

        success(String token) {
          PersistLogin().saveToken(token);
          PersistLogin().saveUserType(activeIndex == 0 ? 'user' : 'owner');

          Navigator.of(context).pushNamedAndRemoveUntil(
            activeIndex == 0 ? UserHome.kRouteName : OwnerHome.kRouteName,
            (route) => false,
          );
        }

        if (formKey.currentState.validate()) {
          if (activeIndex == 0) {
            UserApi()
                .login(
                  email: emailController.text,
                  password: passwordController.text,
                )
                .then(success)
                .catchError(error);
          } else {
            OwnerApi()
                .login(
                  email: emailController.text,
                  password: passwordController.text,
                )
                .then(success)
                .catchError(error);
          }
        }
      }, "Entra"),
    ];
  }

  List<Widget> _buildInputTexts() {
    return [
      CustomInputText(
        controller: emailController,
        labelText: "Email",
        keyboardType: TextInputType.emailAddress,
        validator: validateEmail,
        prefixIcon: Icon(
          Icons.person,
          color: AppStyles.kPrimaryColor,
        ),
      ),
      PasswordInputText(
        controller: passwordController,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kStandardPadding),
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: buildTitle(
                            'Login',
                            Provider.of<SwitchNotifier>(context).activeIndex ==
                                    0
                                ? 'Utente'
                                : 'Proprietario',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _buildButtons(context, constraints),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: kStandardPadding),
                  height: constraints.maxHeight / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ..._buildInputTexts(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
