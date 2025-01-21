import 'dart:async';
import 'dart:io';
import 'package:hng_shoppers/constants/constants.dart';
import 'package:hng_shoppers/constants/toast.dart';
import 'package:http/http.dart' as http;

Future<http.Response> httpGet({
  required String url,
  String? token,
}) async {
  try {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };

    var res = await http
        .get(Uri.parse(baseUrl + url), headers: headers)
        .timeout(const Duration(seconds: 60));

    return res;
  } on SocketException {
    toast(message: 'No Internet connection');
    return http.Response('No Internet connection', 503); // Service Unavailable
  } on TimeoutException {
    toast(message: 'Request timed out');
    return http.Response('Request timed out', 408); // Request Timeout
  } catch (e) {
    toast(message: 'An unexpected error occurred: $e');
    return http.Response(
        'An unexpected error occurred', 500); // Internal Server Error
  }
}

Future<http.Response> httpPost({
  required String url,
  dynamic body,
  String? token,
}) async {
  try {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
    // Make the HTTP POST request
    var res = await http.post(
      Uri.parse(baseUrl + url),
      body: body,
      headers: headers,
    );
    //.timeout(const Duration(seconds: 60));
    return res;
  } on SocketException {
    toast(message: 'No Internet connection');
    return http.Response('No Internet connection', 503); // Service Unavailable
  } on TimeoutException {
    toast(message: 'Request timed out');
    return http.Response('Request timed out', 408); // Request Timeout
  } catch (e) {
    toast(message: 'An unexpected error occurred: $e');
    print('response: $e');
    return http.Response('An unexpected error occurred', 501);
  }
}
