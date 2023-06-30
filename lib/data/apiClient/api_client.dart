import 'dart:convert';
import 'dart:io'; // Import this for SocketException

import 'package:http/http.dart' as http;
import 'package:rainroot/core/constants/utils.dart';

Future<Map<String, dynamic>> userLogin(String email, String password) async {
  String url = Utils.baseUrl + "/auth/signin";
  print('URL for request: $url');
  try {
    final response = await http.post(
      Uri.parse(url),
      body: {"email": email, "password": password},
      headers: {
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      var convertDataToJson = jsonDecode(response.body);

      if (convertDataToJson is Map<String, dynamic>) {
        return convertDataToJson;
      } else {
        throw Exception('Invalid format received from the server');
      }
    } else if (response.statusCode == 400) {
      // Bad Request - Invalid credentials
      var errorJson = jsonDecode(response.body);
      var errorMessage = errorJson['message'];
      throw Exception(errorMessage);
    } else if (response.statusCode == 404) {
      // Not Found - User not found
      throw Exception('Utilisateur introuvable');
    } else {
      throw Exception(
          'Server responded with status code: ${response.statusCode}');
    }
  } on SocketException catch (_) {
    return {'error': 'Connexion refusée'};
  } catch (e) {
    print('Error occurred: $e');
    return {'error': 'Une erreur inattendue est survenue'};
  }
}

Future<Map<String, dynamic>> createUser(String firstName, String lastName, String email, String password) async {
  String url = Utils.baseUrl + "/auth/signup";
  print('URL for request: $url');
  try {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "roles": ["user"]
      }),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 201) {
      var convertDataToJson = jsonDecode(response.body);

      if (convertDataToJson is Map<String, dynamic>) {
        return convertDataToJson;
      } else {
        throw Exception('Invalid format received from the server');
      }
    } else if (response.statusCode == 400) {
      // Bad Request - Invalid data
      var errorJson = jsonDecode(response.body);
      var errorMessage = errorJson['message'];
      throw Exception(errorMessage);
    } else {
      throw Exception(
          'Server responded with status code: ${response.statusCode}');
    }
  } on SocketException catch (_) {
    return {'error': 'Connexion refusée'};
  } catch (e) {
    print('Error occurred: $e');
    return {'error': 'Une erreur inattendue est survenue'};
  }
}



