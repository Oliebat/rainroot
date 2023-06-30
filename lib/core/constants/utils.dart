import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static String baseUrl = 'http://192.168.1.16:8080/api'; //ip maison
  // static String baseUrl = 'http://172.16.0.152:8080/api'; // NFS

}

class TokenUtils {
  static Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
