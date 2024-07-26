class InitPaymentInputSheetModel {
  final String clientSecret;
  final String customerId;
  final String ephemeralKey;

  InitPaymentInputSheetModel({
    required this.clientSecret,
    required this.customerId,
    required this.ephemeralKey,
  });
}
