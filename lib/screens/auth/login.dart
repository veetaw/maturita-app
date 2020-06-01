import 'package:flutter/material.dart';
import 'package:pizza/common/widget/custom_input_text.dart';
import 'package:pizza/common/widget/custom_switch.dart';
import 'package:pizza/screens/auth/common.dart';
import 'package:pizza/screens/auth/register_owner.dart';
import 'package:pizza/screens/auth/register_user.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:provider/provider.dart';

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
    return [
      CustomSwitch(
        constraints: constraints,
        tapCallback: (i) =>
            Provider.of<SwitchNotifier>(context, listen: false).activeIndex = i,
      ),
      buildNextButton(() {
        if (Provider.of<SwitchNotifier>(
              context,
              listen: false,
            ).activeIndex ==
            0)
          Navigator.of(context).pushNamed(RegisterUser.kRouteName);
        else
          Navigator.of(context).pushNamed(RegisterOwner.kRouteName);
      }, "Registrati"),
      buildNextButton(() {}, "Entra"),
    ];
  }

  List<Widget> _buildInputTexts() {
    return [
      CustomInputText(
        labelText: "Email",
        prefixIcon: Icon(
          Icons.person,
          color: AppStyles.kPrimaryColor,
        ),
      ),
      PasswordInputText(),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: buildTitle(
                          'Login',
                          Provider.of<SwitchNotifier>(context).activeIndex == 0
                              ? 'Utente'
                              : 'Proprietario',
                        ),
                      ),
                      ..._buildButtons(context, constraints),
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
