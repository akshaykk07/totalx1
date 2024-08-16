// Custom Text Widget class....
import 'package:flutter/material.dart';
import 'constants/colors.dart';


class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.name,
    this.colors = whiteone,
    this.size,
    this.fontWeight,
  });

  final String name;
  final Color colors;
  final double? size;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
          color: colors,
          overflow: TextOverflow.fade,
          fontSize: size,
          fontWeight: fontWeight),
    );
  }
}
