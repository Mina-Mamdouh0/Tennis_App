import 'package:flutter/material.dart';

class StaticRatingBar extends StatelessWidget {
  const StaticRatingBar({super.key, required this.rating, this.iconSize = 24});
  final double rating;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          color: Colors.orangeAccent,
          size: iconSize,
        ),
      ),
    );
  }
}
