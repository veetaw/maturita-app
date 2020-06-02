import 'package:flutter/material.dart';
import 'package:pizza/common/widget/time_delta_selector.dart';
import 'package:pizza/screens/auth/common.dart';
import 'package:pizza/screens/auth/create_menu.dart';
import 'package:pizza/services/owner_api.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:provider/provider.dart';

class CreateOpenings extends StatelessWidget {
  final OwnerApi api;
  static const String kRouteName =
      'login/registerOwner/createPizzeria/createOpenings';

  const CreateOpenings({Key key, @required this.api}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.kBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ChangeNotifierProvider<OpeningsNotifier>(
          create: (_) => OpeningsNotifier(),
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
                      onTap: (time) =>
                          Provider.of<OpeningsNotifier>(context, listen: false)
                              .setOpening1(0, time),
                      onTap2: (time) =>
                          Provider.of<OpeningsNotifier>(context, listen: false)
                              .setOpening1(1, time),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: kStandardPadding,
                      ),
                    ),
                    TimeDeltaSelector(
                      constraints: constraints,
                      onTap: (time) =>
                          Provider.of<OpeningsNotifier>(context, listen: false)
                              .setOpening2(0, time),
                      onTap2: (time) =>
                          Provider.of<OpeningsNotifier>(context, listen: false)
                              .setOpening2(1, time),
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
          () async {
            error(_) => Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Impossibile aggiungere apertura'),
                  ),
                );

            List<TimeOfDay> times1 =
                Provider.of<OpeningsNotifier>(context, listen: false).opening1;
            List<TimeOfDay> times2 =
                Provider.of<OpeningsNotifier>(context, listen: false).opening2;
            bool valid = false;
            if (times1.length == 2 && times1.every((i) => i != null)) {
              await api
                  .addOpening(
                    start: times1[0].format(context),
                    end: times1[1].format(context),
                  )
                  .catchError(error);
              valid = true;
            }
            if (times2.length == 2 && times2.every((i) => i != null)) {
              await api
                  .addOpening(
                    start: times2[0].format(context),
                    end: times2[1].format(context),
                  )
                  .catchError(error);
              valid = true;
            }
            if (!valid)
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Compila i campi'),
                ),
              );
            else
              Navigator.of(context).pushNamed(
                CreateMenu.kRouteName,
                arguments: api,
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
                      onTap: (time) =>
                          Provider.of<OpeningsNotifier>(context, listen: false)
                              .setOpening1(0, time),
                      onTap2: (time) =>
                          Provider.of<OpeningsNotifier>(context, listen: false)
                              .setOpening1(1, time),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: kStandardPadding,
                      ),
                    ),
                    TimeDeltaSelector(
                      constraints: constraints,
                      onTap: (time) =>
                          Provider.of<OpeningsNotifier>(context, listen: false)
                              .setOpening2(0, time),
                      onTap2: (time) =>
                          Provider.of<OpeningsNotifier>(context, listen: false)
                              .setOpening2(1, time),
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

class OpeningsNotifier extends ChangeNotifier {
  List<TimeOfDay> opening1 = [null, null];
  List<TimeOfDay> opening2 = [null, null];

  setOpening1(int index, TimeOfDay time) {
    opening1[index] = time;

    notifyListeners();
  }

  setOpening2(int index, TimeOfDay time) {
    opening2[index] = time;

    notifyListeners();
  }
}
