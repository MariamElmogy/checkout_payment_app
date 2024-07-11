import 'package:checkout_payment_ui/core/utils/images_data.dart';
import 'package:checkout_payment_ui/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar buildAppBar({required final String title}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: Styles.style25,
    ),
    leading: Center(
      child: SvgPicture.asset(ImagesData.kArrowBack),
    ),
  );
}
