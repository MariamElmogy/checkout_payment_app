import 'package:checkout_payment_ui/core/utils/api_key.dart';
import 'package:checkout_payment_ui/core/utils/api_service.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  final ApiService apiService = ApiService();
  
  // paymentIntentObject create Payment Intent (amount, currency)
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKey.secretKey,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  // init payment sheet (paymentIntentClientSecret)
  // presentPaymentSheet()
}
