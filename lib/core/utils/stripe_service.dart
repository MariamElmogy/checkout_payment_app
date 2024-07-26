import 'package:checkout_payment_ui/core/utils/api_key.dart';
import 'package:checkout_payment_ui/core/utils/api_service.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/init_payment_input_sheet_model.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/feature/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  final ApiService apiService = ApiService();

  // paymentIntentObject create Payment Intent (amount, currency)
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.post(
      contentType: Headers.formUrlEncodedContentType,
      body: paymentIntentInputModel.toJson(),
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKey.secretKey,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  // create ephemral key(customerId)
  Future<EphemeralKeyModel> createEphemeralKey(
      {required String customerId}) async {
    var response = await apiService.post(
      contentType: Headers.formUrlEncodedContentType,
      body: {'customer': customerId},
      url: 'https://api.stripe.com/v1/ephemeral_keys',
      token: ApiKey.secretKey,
      headers: {
        'Authorization': "Bearer ${ApiKey.secretKey}",
        'Stripe-Version': "2024-04-10",
      },
    );

    var ephemeralKeyModel = EphemeralKeyModel.fromJson(response.data);
    return ephemeralKeyModel;
  }

  // old -> init payment sheet (paymentIntentClientSecret)
  // new -> init payment sheet (merchantDisplayName, intentClientSecret, ephemeralKeySecret)
  Future initPaymentSheet(
      {required InitPaymentInputSheetModel initPaymentInputSheetModel}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: initPaymentInputSheetModel.clientSecret,
        customerEphemeralKeySecret: initPaymentInputSheetModel.ephemeralKey,
        customerId: initPaymentInputSheetModel.customerId,
        merchantDisplayName: 'Mariam',
      ),
    );
  }

  // presentPaymentSheet()
  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephemeralKey = await createEphemeralKey(
        customerId: paymentIntentInputModel.customerId!);
    var initPaymentSheetInputModel = InitPaymentInputSheetModel(
      clientSecret: paymentIntentModel.clientSecret!,
      customerId: paymentIntentInputModel.customerId!,
      ephemeralKey: ephemeralKey.secret!,
    );
    await initPaymentSheet(
      initPaymentInputSheetModel: initPaymentSheetInputModel,
    );
    await displayPaymentSheet();
  }
}
