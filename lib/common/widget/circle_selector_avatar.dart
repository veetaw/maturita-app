import 'package:flutter/material.dart';
import 'package:pizza/style/app_styles.dart';

class CircleSelectorAvatar extends StatelessWidget {
  final Function onTap;
  final Widget image;
  const CircleSelectorAvatar({
    Key key,
    @required this.onTap,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: AppStyles.kCardColor,
          shape: BoxShape.circle,
        ),
        child: image ??
            Center(
              child: Icon(
                Icons.camera_alt,
                color: AppStyles.kPrimaryColor,
              ),
            ),
      ),
    );
  }
}
