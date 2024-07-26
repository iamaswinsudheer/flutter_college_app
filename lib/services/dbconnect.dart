import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tc_college_app/services/manageToken.dart';
import 'package:url_launcher/url_launcher.dart';

class DbConnector {
  final String baseUrl;
  DbConnector({this.baseUrl = "https://aviation.danwand.in"});

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


  //function for loading privacy policy in browser
  Future<void> launchPrivacyPolicy()async{
    if(!await launchUrl(Uri.parse('$baseUrl/privacy'))){
      throw Exception('url launch failed');
    };
  }
}
