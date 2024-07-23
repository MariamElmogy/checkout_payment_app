import 'package:checkout_payment_ui/core/errors/failure.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/payment_intent_input_model.dart';
import 'package:dartz/dartz.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
