import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pizza/style/app_styles.dart';
import 'package:undraw/undraw.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (!kIsWeb)
            UnDraw(
              illustration: UnDrawIllustration.pizza_sharing,
              color: AppStyles.kSecondaryAccentColor,
              placeholder: CircularProgressIndicator(),
              errorWidget: Container(),
              height: isPortrait ? size.height / 2 : size.height / 3,
              width: isPortrait ? size.width : size.width / 2,
            ),
          Text(
            "Login in corso ...",
            style: Theme.of(context).textTheme.headline5,
          ),
          FlatButton(
            color: AppStyles.kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onPressed: () async {},
            textColor: Colors.white,
            child: Container(
              alignment: Alignment.center,
              width: size.width - (kStandardPadding * 2),
              child: Text("Rieffettua login"),
            ),
          ),
        ],
      ),
    );
  }
}
