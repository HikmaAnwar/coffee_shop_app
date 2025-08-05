import 'dart:math';

class PaymentService {
  // Simulate payment processing
  static Future<PaymentResult> processPayment({
    required double amount,
    required String paymentMethod,
    required String currency,
  }) async {
    // Simulate API call delay
    await Future.delayed(Duration(seconds: 2));

    // Simulate payment success/failure (90% success rate)
    final random = Random();
    final isSuccess = random.nextDouble() > 0.1;

    if (isSuccess) {
      return PaymentResult(
        success: true,
        transactionId: 'TXN${DateTime.now().millisecondsSinceEpoch}',
        message: 'Payment successful!',
        amount: amount,
        currency: currency,
      );
    } else {
      return PaymentResult(
        success: false,
        transactionId: null,
        message: 'Payment failed. Please try again.',
        amount: amount,
        currency: currency,
      );
    }
  }
}

class PaymentResult {
  final bool success;
  final String? transactionId;
  final String message;
  final double amount;
  final String currency;

  PaymentResult({
    required this.success,
    this.transactionId,
    required this.message,
    required this.amount,
    required this.currency,
  });
}
