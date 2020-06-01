import 'package:flutter/material.dart';
import 'package:pizza/style/app_styles.dart';

List<Widget> buildTitle(String title, String subtitle) {
  return [
    Text(
      title,
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w200,
      ),
    ),
    Text(
      subtitle,
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w500,
      ),
    ),
  ];
}

Widget buildNextButton(
  Function onPressed,
  String text,
) =>
    MaterialButton(
      height: 50,
      onPressed: onPressed,
      color: AppStyles.kPrimaryColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
