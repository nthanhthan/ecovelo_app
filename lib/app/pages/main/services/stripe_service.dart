import 'package:dio/dio.dart';
import 'package:ecoveloapp/app/core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService extends BaseApiClient {
  void _init() {
    Stripe.publishableKey =
        "pk_test_51N9NAuBZOL4eX2j0j4KBjoYlmzJNtzHS2iEGtW0ktbIJPyYtDxkEqUEKti9QUIXRlJyz7cepkoSDtHUa3NP5ldaE00yTC9yOfa";
  }

  Future<void> payment(String userID, int money) async {
    _init();
     await _createCustomer(userID);
    final paymentIntent = await _createPaymentIntents(userID, money);
    await _createCreditCard(
      userID,
      paymentIntent.data['client_secret'],
    );
  }

  Map<String, dynamic> getHeader() {
    String secretKey =
        "sk_test_51N9NAuBZOL4eX2j0JQtZhA19ircZj1xu9INXVyXtL8q61QmtFfDAPyvAk7u11Rd1IhoOxtBFkC73gthwfznW4N6g00Xd0uaotG";
    Map<String, String> headers = {
      "Authorization": "Bearer $secretKey",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    return headers;
  }

  Future<BaseResp<dynamic>> _createCustomer(String userID) async {
    String url = 'https://api.stripe.com/v1/customers';

    return request<dynamic>(
      Method.post,
      url,
      options: Options(headers: getHeader()),
      data: {'description': userID},
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<dynamic>> _createPaymentIntents(
      String customer, int money) async {
    String url = 'https://api.stripe.com/v1/payment_intents';
    Map<String, dynamic> body = {
      "currency": "vnd",
      "payment_method_types[]": "card",
      "amount": money,
    };
    return request<dynamic>(
      Method.post,
      url,
      options: Options(headers: getHeader()),
      data: body,
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<void> _createCreditCard(
      String customerId, String paymentIntentClientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: 'Flutter Stripe Store Demo',
        customerId: customerId,
        paymentIntentClientSecret: paymentIntentClientSecret,
        allowsDelayedPaymentMethods: true,
      ),
    );
      await Stripe.instance.presentPaymentSheet();
  }
}
