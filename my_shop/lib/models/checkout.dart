import 'package:dio/dio.dart';
import 'package:my_shop/models/api_keys.dart';

class Checkout {
  static Checkout _instance = Checkout._private();

  Checkout._private();

  static Checkout get instance => _instance;

  static const _tokenUrl = 'https://api.sandbox.checkout.com/tokens';
  static const _paymentUrl = 'https://api.sandbox.checkout.com/payments';
  Dio _dio = Dio();

  Future<String> getToken(
      String cardNumber, int expiryMonth, int expiryYear, int cvv) async {
    Response response = await _dio.post(_tokenUrl,
        data: {
          'type': 'card',
          'number': cardNumber,
          'expiry_month': expiryMonth,
          'expiry_year': expiryYear,
          'cvv': cvv,
        },
        options: Options(headers: {'AUTHORIZATION': ApiKeys.pk}));
    return response.data['token'];
  }

  Future<bool> pay(String token, int amount) async {
    Response response = await _dio.post(_paymentUrl,
        data: {
          'source': {
            'type': 'token',
            'token': token,
          },
          'amount': amount,
          'currency': 'USD',
        },
        options: Options(headers: {'AUTHORIZATION': ApiKeys.sk}));
    return response.data['approved'];
  }
}
