import 'package:shared_preferences/shared_preferences.dart';

class TokenManager{
  static const String tokenKey = 'tokenKey';
  
  static Future<void> saveToken(String accessToken) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(tokenKey, accessToken);
  }

  static Future<String?> getToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  static Future<void> destroyToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(tokenKey);
  }

}