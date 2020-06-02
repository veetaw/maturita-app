import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizza/style/app_styles.dart';

class PasswordInputText extends StatefulWidget {
  final TextEditingController controller;

  const PasswordInputText({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  _PasswordInputTextState createState() => _PasswordInputTextState();
}

class _PasswordInputTextState extends State<PasswordInputText> {
  bool obscured = true;

  @override
  Widget build(BuildContext context) {
    return CustomInputText(
      labelText: "Password",
      controller: widget.controller,
      prefixIcon: Icon(
        Icons.vpn_key,
        color: AppStyles.kPrimaryColor,
      ),
      obscured: obscured,
      suffixIcon: InkWell(
        onTap: () => setState(() => obscured = !obscured),
        child: Icon(
          obscured ? Icons.visibility : Icons.visibility_off,
          color: AppStyles.kPrimaryColor,
        ),
      ),
    );
  }
}

class CustomInputText extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool obscured;
  final Function(String) validator;
  final List<TextInputFormatter> formatters;
  final TextInputType keyboardType;

  const CustomInputText({
    Key key,
    this.controller,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscured,
    this.validator,
    this.formatters,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyles.kCardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        inputFormatters: formatters,
        keyboardType: keyboardType,
        obscureText: obscured ?? false,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: AppStyles.kPrimaryColor),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
