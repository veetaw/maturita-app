import 'package:flutter/material.dart';
import 'package:pizza/style/app_styles.dart';

class CustomSwitch extends StatefulWidget {
  final BoxConstraints constraints;
  final Function(int) tapCallback;
  final List<String> titles;

  CustomSwitch({
    Key key,
    @required this.constraints,
    this.tapCallback,
    this.titles,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    double width = widget.constraints.maxWidth;
    double height = widget.constraints.maxHeight;
    if (width > height) width /= 2;

    final halfContainerWidth = (width - kStandardPadding * 2) / 2;
    return InkWell(
      onTap: () {
        setState(() {
          activeIndex = activeIndex == 0 ? 1 : 0;
          if (widget.tapCallback != null) widget.tapCallback(activeIndex);
        });
      },
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
          color: AppStyles.kSecondaryAccentColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            _buildSwitch(halfContainerWidth),
            Positioned(
              left: 0,
              child: _buildText(
                widget.titles != null ? widget.titles[0] :  'Utente',
                halfContainerWidth,
              ),
            ),
            Positioned(
              right: 0,
              child: _buildText(
                widget.titles != null ? widget.titles[1] :  'Proprietario',
                halfContainerWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildText(String text, double halfContainerWidth) {
    return Container(
      height: 50,
      width: halfContainerWidth,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Positioned _buildSwitch(double halfContainerWidth) {
    return Positioned(
      left: activeIndex == 0 ? 0 : null,
      right: activeIndex == 1 ? 0 : null,
      child: Container(
        height: 50,
        width: halfContainerWidth,
        decoration: BoxDecoration(
          color: AppStyles.kAccentColor,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class SwitchNotifier extends ChangeNotifier {
  int _activeIndex = 0;
  SwitchNotifier();

  set activeIndex(int newActiveIndex) {
    _activeIndex = newActiveIndex;
    notifyListeners();
  }

  get activeIndex => _activeIndex;
}
