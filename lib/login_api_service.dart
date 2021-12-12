import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginApiServices {
  Future<LoginApiResponse> apiCallLogin(Map<String, String> param) async {
    // var response = await Dio().post(
    //     "https://adultfamilyhomes.org/api/myafh/login?role=user",
    //     data: param);
    // final data = json.decode(response.data);
    // if (response.statusMessage == "failed") {}
    // return LoginApiResponse(
    //   token: data["token"],
    //   error: data["error"],
    // );
    final response = await http.post(
      Uri.parse('https://adultfamilyhomes.org/api/myafh/login?role=user'),
      body: json.encode(param),
    );
    final data = json.decode(response.body);
    if (data['status'] == 'failed') {
      return LoginApiResponse(
        error: data["status"],
      );
    } else {
      return LoginApiResponse(
        token: data["token"],
      );
    }
  }
}

class LoginApiResponse {
  final String token;
  final String error;

  LoginApiResponse({
    this.token,
    this.error,
  });
}
