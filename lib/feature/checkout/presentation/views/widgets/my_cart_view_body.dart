import 'package:checkout_payment_ui/core/utils/images_data.dart';
import 'package:checkout_payment_ui/feature/checkout/data/repos/checkout_repo_implement.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/views/widgets/custom_button.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/views/widgets/order_info_item.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/views/widgets/payment_methods_bottom_sheet.dart';
import 'package:checkout_payment_ui/feature/checkout/presentation/views/widgets/total_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 18),
          Expanded(
            child: Image.asset(ImagesData.kBasketImage),
          ),
          const OrderInfoItem(
            title: 'Order Subtotal',
            value: r'$42.97',
          ),
          const SizedBox(height: 3),
          const OrderInfoItem(
            title: 'Discount',
            value: r'$0',
          ),
          const SizedBox(height: 3),
          const OrderInfoItem(
            title: 'Shipping',
            value: r'$8',
          ),
          const SizedBox(height: 3),
          const Divider(
            thickness: 2,
            color: Color(0XFFC7C7C7),
            height: 34,
          ),
          const TotalPrice(),
          const SizedBox(height: 16),
          CustomButton(
            isLoading: false,
            text: 'Complete Payment',
            // onTap: () => Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const PaymentDetailsView(),
            //   ),
            // ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                builder: (context) => BlocProvider(
                  create: (context) => PaymentCubit(CheckoutRepoImplement()),
                  child: const PaymentMethodsBottomSheet(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
