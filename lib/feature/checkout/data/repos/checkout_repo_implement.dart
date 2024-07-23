import 'package:checkout_payment_ui/core/errors/failure.dart';
import 'package:checkout_payment_ui/core/utils/stripe_service.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/feature/checkout/data/repos/checkout_repo.dart';
import 'package:dartz/dartz.dart';

class CheckoutRepoImplement extends CheckoutRepo {
  final StripeService stripeService = StripeService();

  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    } catch (e) {
      return left(ServiceFailure(errMessage: e.toString()));
    }
  }
}
