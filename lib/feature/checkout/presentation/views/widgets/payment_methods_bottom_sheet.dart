import 'dart:developer';

import 'package:checkout_payment_ui/feature/checkout/presentation/views/widgets/custom_button_bloc_consumer.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/views/widgets/payment_methods_list_view.dart';
import 'package:flutter/material.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  State<PaymentMethodsBottomSheet> createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  int payIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          PaymentMethodsListView(
            paymentMethodSelection: (payWith) => setState(() {
              payIndex = payWith;
              log('payIndex $payWith - $payIndex');
            }),
          ),
          const SizedBox(height: 32),
          CustomButtonBlocConsumer(payWith: payIndex),
        ],
      ),
    );
  }
}
