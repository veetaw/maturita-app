import 'package:flutter/material.dart';
import 'package:pizza/common/widget/circle_selector_avatar.dart';
import 'package:pizza/common/widget/custom_input_text.dart';
import 'package:pizza/screens/auth/auth.dart';
import 'package:pizza/screens/auth/common.dart';
import 'package:pizza/style/app_styles.dart';

class CreatePizzeria extends StatelessWidget {
  static const String kRouteName = 'login/registerOwner/createPizzeria';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.kBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxHeight > constraints.maxWidth)
              return _buildPortrait(context, constraints);
            else
              return _buildLandscape(context, constraints);
          },
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

  Column _buildButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildNextButton(() {
          Navigator.of(context).pushNamed(
            CreateOpenings.kRouteName,
          );
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
            prefixIcon: Icon(
              Icons.person,
              color: AppStyles.kPrimaryColor,
            ),
          ),
          CustomInputText(
            labelText: "P.IVA",
            prefixIcon: Icon(
              Icons.business,
              color: AppStyles.kPrimaryColor,
            ),
          ),
          CustomInputText(
            labelText: "address",
            prefixIcon: Icon(
              Icons.home,
              color: AppStyles.kPrimaryColor,
            ),
          ),
          CustomInputText(
            labelText: "phone",
            prefixIcon: Icon(
              Icons.phone,
              color: AppStyles.kPrimaryColor,
            ),
          ),
          CustomInputText(
            labelText: "email",
            prefixIcon: Icon(
              Icons.email,
              color: AppStyles.kPrimaryColor,
            ),
          ),
          PasswordInputText(),
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
                          children: buildTitle('Dati', 'Pizzeria'),
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
