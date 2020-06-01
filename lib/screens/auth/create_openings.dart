import 'package:flutter/material.dart';
import 'package:pizza/common/widget/time_delta_selector.dart';
import 'package:pizza/screens/auth/common.dart';
import 'package:pizza/screens/auth/create_menu.dart';
import 'package:pizza/style/app_styles.dart';

class CreateOpenings extends StatelessWidget {
  static const String kRouteName =
      'login/registerOwner/createPizzeria/createOpenings';

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildTitle(),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kStandardPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TimeDeltaSelector(
                      constraints: constraints,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: kStandardPadding,
                      ),
                    ),
                    TimeDeltaSelector(
                      constraints: constraints,
                    ),
                  ],
                ),
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
            Navigator.of(context).pushNamed(
              CreateMenu.kRouteName,
            );
          },
          "Avanti",
        ),
      ],
    );
  }

  List<Widget> _buildTitle() {
    return [
      Text(
        'Orari',
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w200,
        ),
      ),
      Text(
        'Apertura',
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: buildTitle('Orari', 'Apertura'),
                    ),
                    _buildButton(context),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(kStandardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TimeDeltaSelector(
                      constraints: constraints,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: kStandardPadding,
                      ),
                    ),
                    TimeDeltaSelector(
                      constraints: constraints,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
