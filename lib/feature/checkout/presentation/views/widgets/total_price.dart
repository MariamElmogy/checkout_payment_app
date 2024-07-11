import 'package:checkout_payment_ui/core/utils/styles.dart';
import 'package:flutter/material.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Total',
          style: Styles.style24,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Text(
          r'$50.97',
          style: Styles.style24,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
