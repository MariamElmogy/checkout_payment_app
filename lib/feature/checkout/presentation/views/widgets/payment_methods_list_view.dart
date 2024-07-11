import 'package:checkout_payment_ui/core/utils/images_data.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/views/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});
  final List<String> paymentMethodItems = const [
    ImagesData.kCard,
    ImagesData.kPaypal,
    ImagesData.kMasterCard,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ListView.builder(
        itemCount: paymentMethodItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: PaymentMethodItem(
              isActive: false,
              image: paymentMethodItems[index],
            ),
          );
        },
      ),
    );
  }
}
