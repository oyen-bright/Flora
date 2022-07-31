import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora/models/content_model.dart';
import 'package:flora/screens/movies.dart';
import 'package:flora/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flora/screens/screens.dart';
import 'package:flora/assets.dart';
import 'package:flora/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;

  const CustomAppBar({
    Key key,
    this.scrollOffset = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 24.0,
        ),
        color: Colors.black
            .withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
        child: _CustomAppBarMobile());
  }
}

class _CustomAppBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.floraLogo),
          const SizedBox(width: 12.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(
                    title: 'Movies',
                    onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AllMovies(isNav: false)))
                        }),
                _AppBarButton(
                  title: 'My List',
                  onTap: () => {
                    Navigator.push(
                        //try adding context to the underscore for firebase data
                        context,
                        MaterialPageRoute(builder: (_) => MyList()))
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const _AppBarButton({
    Key key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
