// Custom Button Class........
import 'package:flutter/material.dart';


import 'apptext.dart';
import 'constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.size,
    required this.titile,
  });

  final Size size;
  final String titile;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: size.width,
      decoration: BoxDecoration(
          color: customBalck, borderRadius: BorderRadius.circular(40)),
      child: Center(
        child: AppText(
          name: titile,
          size: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class CustomButton1 extends StatelessWidget {
  const CustomButton1({
    super.key,
    required this.size,
    this.type = false,
    required this.title,
    this.onTap,
  });

  final Size size;
  final bool type;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: type ? blue : Colors.grey.shade300),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.08, vertical: size.height * 0.01),
          child: AppText(
            name: title,
            size: 12,
            fontWeight: FontWeight.w500,
            colors: type ? white : customBalck,
          ),
        ),
      ),
    );
  }
}
