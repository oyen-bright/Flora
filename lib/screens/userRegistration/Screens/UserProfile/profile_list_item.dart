import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final Function onClick;

  ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 40,
        ).copyWith(
          bottom: 20,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              size: 25,
            ),
            SizedBox(width: 15),
            Text(this.text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            Spacer(),
            if (this.hasNavigation)
              Icon(
                Icons.arrow_back,
                size: 25,
              ),
          ],
        ),
      ),
    );
  }
}
