import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<void> makePaymentRequest(
    String merchantKey,
    String password,
  ) async {
    try {
      const baseUrl = 'https://pay.expresspay.sa';
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final String paymentId =
          generateUUID('xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx');
      final String hash = generateHash(paymentId, merchantKey, password);

      final Map<String, dynamic> requestBody = {
        'merchant_key': 'e4e9de2c-0a7c-11ee-a1ce-f2277508023e',
        'Password': '0663160c15057dc9ed156b3f8d9aff51',
        'payment_id': paymentId,
        'hash': hash,
        // Add any additional request parameters here
      };

      final http.Response response = await http.post(
        Uri.parse('$baseUrl/api/v1/payment/reсurring'),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Payment request successful
        final responseData = jsonDecode(response.body);
        // Process the response data
        print(responseData);
      } else {
        // Payment request failed
        print(
            'Payment request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  String generateUUID(String format) {
    return format.replaceAllMapped(RegExp('[xy]'), (match) {
      final random = Random.secure();
      final value = random.nextInt(16);
      final digit = match.group(0) == 'x' ? value : (value & 0x3 | 0x8);
      return digit.toRadixString(16);
    });
  }

  String generateHash(String paymentId, String merchantKey, String password) {
    final String concatenatedString = merchantKey + password + paymentId;
    final List<int> bytes = utf8.encode(concatenatedString);
    final Digest digest = sha512.convert(bytes);
    final String hash = hex.encode(digest.bytes);
    return hash;
  }
}
