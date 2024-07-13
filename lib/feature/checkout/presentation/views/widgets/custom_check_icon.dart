import 'package:flutter/material.dart';

class CustomCheckIcon extends StatelessWidget {
  const CustomCheckIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundColor: Color(0XFFD9D9D9),
      radius: 50,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Color(0XFF34A853),
        child: Icon(
          Icons.check,
          size: 50,
        ),
      ),
    );
  }
}
