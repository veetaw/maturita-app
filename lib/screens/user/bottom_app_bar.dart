import 'package:flutter/material.dart';
import 'package:pizza/style/app_styles.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: MediaQuery.of(context).size.width / 3,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppStyles.kSecondaryAccentColor,
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.shopping_cart,
              color: AppStyles.kPrimaryColor,
            ),
            Text(
              "Carrello",
              style: TextStyle(
                color: AppStyles.kPrimaryColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
