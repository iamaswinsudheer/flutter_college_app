import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserAuthentication {
  BuildContext context;
  UserAuthentication({required this.context});
  String tokenUrl = "https://aviation.danwand.in/auth/token/";
  Future<Map<String, dynamic>> getAccessToken(
      String email, String password, String? phone_id) async {
    try {
      final response = await http.post(Uri.parse(tokenUrl),
          body: {'email': email, 'password': password, 'phone_id': phone_id});
      if (response.statusCode == 200) {
        Map<String, dynamic> tokens = jsonDecode(response.body);
        return tokens;
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorMessage = errorResponse['detail'];
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Error: $errorMessage'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return Future.error(
            'Server error : ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
