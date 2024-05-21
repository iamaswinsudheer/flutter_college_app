import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tc_college_app/services/manageToken.dart';

class UserDetailsFetcher {
  Future<List<dynamic>> fetchUserDetails() async {
    String api = 'http://65.21.180.194/auth/profile/';
    String? bearerToken = await TokenManager.getToken();
    try {
      final response = await http.get(Uri.parse(api), headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json'
      });
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception(jsonDecode(response.body));
      }
    } catch (error) {
      throw Exception('exception: $error');
    }
  }
}
