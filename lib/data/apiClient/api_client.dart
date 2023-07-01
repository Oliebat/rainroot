import 'dart:convert';
import 'dart:io'; // Import this for SocketException
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
        return {'error': 'Format de réponse invalide du serveur'};
      }
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      // Bad Request or Not Found - User not found or Invalid credentials
      var errorJson = jsonDecode(response.body);
      return {'error': errorJson['message']};
    } else {
      return {'error': 'Le serveur a répondu avec le code de statut: ${response.statusCode}'};
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
        return {'error': 'Format de réponse invalide du serveur'};
      }
    } else if (response.statusCode == 400) {
      // Bad Request - Invalid data
      var errorJson = jsonDecode(response.body);
      return {'error': errorJson['message']};
    } else {
      return {'error': 'Le serveur a répondu avec le code de statut: ${response.statusCode}'};
    }
  } on SocketException catch (_) {
    return {'error': 'Connexion refusée'};
  } catch (e) {
    print('Error occurred: $e');
    return {'error': 'Une erreur inattendue est survenue'};
  }
}

Future<User> getUserById(String id) async {
  String url = Utils.baseUrl + "/users/$id";
  print('URL for request: $url');
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      var convertDataToJson = jsonDecode(response.body);
      if (convertDataToJson is Map<String, dynamic>) {
        return User.fromJson(convertDataToJson); // Utiliser la factory pour créer un User
      } else {
        throw Exception('Format de réponse invalide du serveur');
      }
    } else if (response.statusCode == 404) {
      // Not Found - User not found
      var errorJson = jsonDecode(response.body);
      throw Exception(errorJson['message']);
    } else {
      throw Exception('Le serveur a répondu avec le code de statut: ${response.statusCode}');
    }
  } on SocketException catch (_) {
    throw Exception('Connexion refusée');
  } catch (e) {
    print('Error occurred: $e');
    throw Exception('Une erreur inattendue est survenue');
  }
}


