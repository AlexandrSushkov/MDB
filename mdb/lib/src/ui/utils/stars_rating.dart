import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  /// [rating] is between 0..10
  StarRating(this.rating);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildRatingBar(Theme.of(context)));
  }

  List<Widget> _buildRatingBar(ThemeData theme) {
    var rating5 = rating / 2;
    List<Widget> stars = [];
    for (var i = 1; i <= 5; i++) {
      var idata;
      if (rating5 > 1) {
        idata = Icons.star;
      } else if (rating5 > 0.5) {
        idata = Icons.star_half;
      } else {
        idata = Icons.star_border;
      }
      stars.add(Icon(
        idata,
        color: theme.accentColor,
      ));
      rating5--;
    }
    return stars;
  }
}
