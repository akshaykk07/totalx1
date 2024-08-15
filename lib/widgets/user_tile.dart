// custom user tile..............
import 'package:flutter/material.dart';

import 'constants/colors.dart';
import 'apptext.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.name,
    required this.age,
    required this.imgurl,
  });
  final String name;
  final String age;
  final String imgurl;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      child: Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 6),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: customBalck,
            backgroundImage: NetworkImage(imgurl),
            radius: 30,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                name: name,
                size: 13,
                fontWeight: FontWeight.w600,
                colors: customBalck,
              ),
              AppText(
                name: 'Age: $age',
                size: 12,
                fontWeight: FontWeight.w500,
                colors: customBalck,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
