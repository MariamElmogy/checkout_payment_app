import 'dart:developer';

import 'package:checkout_payment_ui/core/utils/api_key.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/amount_model/amount_model.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/amount_model/details.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/item_list_model/item.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/item_list_model/item_list_model.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/views/thank_you_view.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/views/widgets/custom_button.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/views/widgets/payment_methods_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 16),
          PaymentMethodsListView(),
          SizedBox(height: 32),
          CustomButtonBlocConsumer(),
        ],
      ),
    );
  }
}

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) {
              return const ThankYouView();
            },
          ));
        }
        if (state is PaymentFailure) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(content: Text(state.errMessage));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return CustomButton(
          onTap: () {
            var transctionData = getTransctionData();
            navigatePayPalPayment(context, transctionData);
            // PaymentIntentInputModel paymentIntentInputModel =
            //     PaymentIntentInputModel(
            //   amount: '100',
            //   currency: 'USD',
            //   customerId: ApiKey.customerId,
            // );
            // BlocProvider.of<PaymentCubit>(context)
            //     .makePayment(paymentIntentInputModel: paymentIntentInputModel);
          },
          text: 'Continue',
          isLoading: state is PaymentLoading ? true : false,
        );
      },
    );
  }

  void navigatePayPalPayment(BuildContext context, ({AmountModel amount, ItemListModel itemList}) transctionData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKey.paypalClientId,
        secretKey: ApiKey.paypalSecretKey,
        transactions: [
          {
            "amount": transctionData.amount.toJson(),
            "description": "The payment transaction description.",
            "item_list": {"items": transctionData.itemList.toJson()}
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.pop(context);
        },
        onError: (error) {
          log("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }

  ({AmountModel amount, ItemListModel itemList}) getTransctionData() {
    var amount = AmountModel(
      currency: 'USD',
      details: Details(shipping: "0", shippingDiscount: 0, subtotal: "100"),
      total: "100",
    );

    List<OrderItemModel> orders = [
      OrderItemModel(
        currency: "USD",
        name: "Apple",
        price: "10",
        quantity: 4,
      ),
      OrderItemModel(
        currency: "USD",
        name: "Pineapple",
        price: "12",
        quantity: 5,
      ),
    ];
    var itemList = ItemListModel(items: orders);
    return (amount: amount, itemList: itemList);
  }
}
