import 'dart:developer';
import 'package:checkout_payment_ui/core/utils/api_key.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/amount_model/amount_model.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/amount_model/details.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/item_list_model/order_item_model.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/item_list_model/item_list_model.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/views/thank_you_view.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
    required this.payWith,
  });

  final int payWith;

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
            if (payWith == 0) {
              PaymentIntentInputModel paymentIntentInputModel =
                  PaymentIntentInputModel(
                amount: '100',
                currency: 'USD',
                customerId: ApiKey.customerId,
              );
              BlocProvider.of<PaymentCubit>(context).makePayment(
                  paymentIntentInputModel: paymentIntentInputModel);
            } else {
              var transctionData = getTransctionData();
              navigatePayPalPayment(context, transctionData);
            }
          },
          text: 'Continue',
          isLoading: state is PaymentLoading ? true : false,
        );
      },
    );
  }

  void navigatePayPalPayment(BuildContext context,
      ({AmountModel amount, ItemListModel itemList}) transctionData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        var transactionPayload = {
          "amount": transctionData.amount.toJson(),
          "description": "The payment transaction description.",
          "item_list": {
            "items":
                transctionData.itemList.items?.map((e) => e.toJson()).toList()
          }
        };
        log("Transaction Payload: $transactionPayload");
        return UsePaypal(
          sandboxMode: true,
          clientId: ApiKey.paypalClientId,
          secretKey: ApiKey.paypalSecretKey,
          returnURL: "https://samplesite.com/return",
          cancelURL: "https://samplesite.com/cancel",
          transactions: [transactionPayload],
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
        );
      },
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
