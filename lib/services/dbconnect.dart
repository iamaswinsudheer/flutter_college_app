import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tc_college_app/services/manageToken.dart';

class DbConnector {
  final String baseUrl;
  DbConnector({this.baseUrl = "http://65.21.180.194"});

  //function for fetching degree books
  Future<List<Map<String, dynamic>>> getDegreeBooks() async {
    String userDataUrl = "$baseUrl/api/degreebooks";
    String? bearerToken = await TokenManager.getToken();
    try {
      final response = await http.get(Uri.parse(userDataUrl), headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json'
      });
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        return Future.error('response code : ${response.statusCode}');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
