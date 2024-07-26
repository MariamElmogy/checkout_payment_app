class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String? customerId;

  PaymentIntentInputModel({
    this.customerId,
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'customer': customerId,
    };
  }
}
