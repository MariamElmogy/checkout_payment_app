import 'package:checkout_payment_ui/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardInfoWidget extends StatelessWidget {
  const CardInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/master_card.svg'),
          const SizedBox(
            width: 23,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Credit Card ',
                  style: Styles.style16,
                ),
                TextSpan(
                  text: 'Mastercard **78',
                  style: Styles.style16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
