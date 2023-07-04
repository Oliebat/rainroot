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
      return {
        'error':
            'Le serveur a répondu avec le code de statut: ${response.statusCode}'
      };
    }
  } on SocketException catch (_) {
    return {'error': 'Connexion refusée'};
  } catch (e) {
    print('Error occurred: $e');
    return {'error': 'Une erreur inattendue est survenue'};
  }
}

Future<Map<String, dynamic>> createUser(
    String firstName, String lastName, String email, String password) async {
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
      return {
        'error':
            'Le serveur a répondu avec le code de statut: ${response.statusCode}'
      };
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

  // Create storage
  final storage = new FlutterSecureStorage();

  // Get token from secure storage
  String? token = await storage.read(key: 'auth_token');
  // verify if token is stored with flutter_secure_storage
  print('Stored token: $token');

  if (token == null) {
    print('Error occurred: Token is null');
    throw Exception('Token is null');
  }

  print('URL for request: $url');
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "x-access-token": "$token",
      },
    );
    print('Headers: ${response.headers}');

    if (response.statusCode == 200) {
      var convertDataToJson = jsonDecode(response.body);
      if (convertDataToJson is Map<String, dynamic>) {
        return User.fromJson(convertDataToJson);
      } else {
        throw Exception('Invalid server response format');
      }
    } else if (response.statusCode == 403) {
      // Forbidden - Access token may be invalid or expired
      var errorJson = jsonDecode(response.body);
      throw Exception('Access Denied: ${errorJson['message']}');
    } else if (response.statusCode == 404) {
      // Not Found - User not found
      var errorJson = jsonDecode(response.body);
      throw Exception('User not found: ${errorJson['message']}');
    } else {
      throw Exception(
          'Server responded with status code: ${response.statusCode}');
    }
  } on SocketException catch (_) {
    print('Error occurred: Connection refused');
    throw Exception('Connection refused');
  } catch (e) {
    print('Error occurred: $e');
    throw Exception('An unexpected error occurred');
  }
}

Future<List<Sprinkler>> getMySprinklers() async {
  String url = Utils.baseUrl + "/my-sprinklers";

  // Create storage
  final storage = new FlutterSecureStorage();

  // Get token from secure storage
  String? token = await storage.read(key: 'auth_token');
  // verify if token is stored with flutter_secure_storage
  print('Stored token: $token');

  if (token == null) {
    print('Error occurred: Token is null');
    throw Exception('Token is null');
  }

  print('URL for request: $url');
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "x-access-token": "$token",
      },
    );
    print('Headers: ${response.headers}');

    if (response.statusCode == 200) {
      var convertDataToJson = jsonDecode(response.body);
      if (convertDataToJson is List) {
        return convertDataToJson
            .map((json) => Sprinkler.fromJson(json))
            .toList();
      } else {
        throw Exception('Invalid server response format');
      }
    } else if (response.statusCode == 403) {
      // Forbidden - Access token may be invalid or expired
      var errorJson = jsonDecode(response.body);
      throw Exception('Access Denied: ${errorJson['message']}');
    } else if (response.statusCode == 404) {
      // Not Found - User not found
      var errorJson = jsonDecode(response.body);
      throw Exception('User not found: ${errorJson['message']}');
    } else {
      throw Exception(
          'Server responded with status code: ${response.statusCode}');
    }
  } on SocketException catch (_) {
    print('Error occurred: Connection refused');
    throw Exception('Connection refused');
  } catch (e) {
    print('Error occurred: $e');
    throw Exception('An unexpected error occurred');
  }
}

Future<void> toggleIrrigation(int sprinklerId, bool isIrrigationOn) async {
  // Build the URL
  String url = Utils.baseUrl + "/sprinklers/$sprinklerId/toggle-irrigation";

  final storage = new FlutterSecureStorage();
  // Get token from secure storage
  String? token = await storage.read(key: 'auth_token');

  if (token == null) {
    throw Exception('Token is null');
  }

  try {
    // Make the HTTP PUT request to the API
    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "x-access-token": "$token",
        "Content-Type": "application/json", // Specify the content type
      },
      body: jsonEncode({
        "isIrrigationOn": isIrrigationOn,
      }),
    );

    // Check the status code of the response
    if (response.statusCode == 200) {
      if (isIrrigationOn) {
        print('Irrigation activated successfully.');
      } else {
        print('Irrigation deactivated successfully.');
      }
    } else if (response.statusCode == 403) {
      // Forbidden - Access token may be invalid or expired
      var errorJson = jsonDecode(response.body);
      throw Exception('Access Denied: ${errorJson['message']}');
    } else if (response.statusCode == 404) {
      // Not Found - Sprinkler not found
      var errorJson = jsonDecode(response.body);
      throw Exception('Sprinkler not found: ${errorJson['message']}');
    } else {
      throw Exception(
          'Server responded with status code: ${response.statusCode}');
    }
  } on SocketException catch (_) {
    throw Exception('Connection refused');
  } catch (e) {
    throw Exception('An unexpected error occurred: $e');
  }
}

// Future<void> activateAutomaticIrrigation(int sprinklerId) async {
//   // Build the URL
//   String url = Utils.baseUrl + "/sprinklers/$sprinklerId/automatic-irrigation";
//   print('URL automatic: $url');

//   final storage = new FlutterSecureStorage();
//   // Get token from secure storage
//   String? token = await storage.read(key: 'auth_token');

//   if (token == null) {
//     throw Exception('Token is null');
//   }

//   try {
//     // Make the HTTP PUT request to the API
//     final response = await http.put(
//       Uri.parse(url),
//       headers: {
//         "Accept": "application/json",
//         "x-access-token": "$token",
//         "Content-Type": "application/json", // Specify the content type
//       },
//     );
//     print('Response data: ${response.body}');

//     // Check the status code of the response
//     if (response.statusCode == 200) {
//       print('Automatic irrigation activated successfully.');
//     } else if (response.statusCode == 403) {
//       // Forbidden - Access token may be invalid or expired
//       var errorJson = jsonDecode(response.body);
//       throw Exception('Access Denied: ${errorJson['message']}');
//     } else if (response.statusCode == 404) {
//       // Not Found - Sprinkler not found
//       var errorJson = jsonDecode(response.body);
//       throw Exception('Sprinkler not found: ${errorJson['message']}');
//     } else {
//       throw Exception(
//           'Server responded with status code: ${response.statusCode}');
//     }
//   } on SocketException catch (_) {
//     throw Exception('Connection refused');
//   } catch (e) {
//     throw Exception('An unexpected error occurred: $e');
//   }
// }
Future<void> activateAutomaticIrrigation(
    int sprinklerId, bool isAutoIrrigationOn) async {
  // Build the URL
  String url = Utils.baseUrl + "/sprinklers/$sprinklerId/automatic-irrigation";
  print('URL automatic: $url');

  final storage = new FlutterSecureStorage();
  // Get token from secure storage
  String? token = await storage.read(key: 'auth_token');

  if (token == null) {
    throw Exception('Token is null');
  }

  try {
    // Make the HTTP PUT request to the API
    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "x-access-token": "$token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "isAutoIrrigationOn": isAutoIrrigationOn,
      }),
    );
    print('Response data: ${response.body}');

    // Check the status code of the response
    if (response.statusCode == 200) {
      if (isAutoIrrigationOn) {
        print('Automatic irrigation activated successfully.');
      } else {
        print('Automatic irrigation deactivated successfully.');
      }
    } else if (response.statusCode == 403) {
      // Forbidden - Access token may be invalid or expired
      var errorJson = jsonDecode(response.body);
      throw Exception('Access Denied: ${errorJson['message']}');
    } else if (response.statusCode == 404) {
      // Not Found - Sprinkler not found
      var errorJson = jsonDecode(response.body);
      throw Exception('Sprinkler not found: ${errorJson['message']}');
    } else {
      throw Exception(
          'Server responded with status code: ${response.statusCode}');
    }
  } on SocketException catch (_) {
    throw Exception('Connection refused');
  } catch (e) {
    throw Exception('An unexpected error occurred: $e');
  }
}

Future<void> updateSprinkler(
    int sprinklerId, String sprinklerName, String location) async {
  String url = Utils.baseUrl + "/sprinklers/$sprinklerId";

  final storage = new FlutterSecureStorage();
  // Get token from secure storage
  String? token = await storage.read(key: 'auth_token');

  if (token == null) {
    throw Exception('Token is null');
  }

  try {
    final Map<String, dynamic> requestData = {
      "sprinkler_name": sprinklerName,
      "location": location,
    };

    if (requestData.containsValue(null)) {
      throw Exception('Invalid data format: Missing required fields');
    }

    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "x-access-token": "$token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestData),
    );

    print('API URL: $url');
    print('Updated Sprinkler Name: $sprinklerName');
    print('Updated Sprinkler Location: $location');
    print('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      print('Sprinkler updated successfully.');
    } else if (response.statusCode == 403) {
      var errorJson = jsonDecode(response.body);
      throw Exception('Access Denied: ${errorJson['message']}');
    } else if (response.statusCode == 404) {
      var errorJson = jsonDecode(response.body);
      throw Exception('Sprinkler not found: ${errorJson['message']}');
    } else {
      throw Exception(
          'Server responded with status code: ${response.statusCode}');
    }
  } on SocketException catch (_) {
    throw Exception('Connection refused');
  } catch (e) {
    throw Exception('An unexpected error occurred: $e');
  }
}

Future<void> deleteSprinkler(int sprinklerId) async {
  String url = Utils.baseUrl + "/sprinklers/$sprinklerId";

  final storage = new FlutterSecureStorage();
  // Get token from secure storage
  String? token = await storage.read(key: 'auth_token');

  if (token == null) {
    throw Exception('Token is null');
  }

  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "x-access-token": "$token",
      },
    );

    print('API URL: $url');
    print('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      print('Sprinkler deleted successfully.');
    } else if (response.statusCode == 403) {
      var errorJson = jsonDecode(response.body);
      throw Exception('Access Denied: ${errorJson['message']}');
    } else if (response.statusCode == 404) {
      var errorJson = jsonDecode(response.body);
      throw Exception('Sprinkler not found: ${errorJson['message']}');
    } else {
      throw Exception(
          'Server responded with status code: ${response.statusCode}');
    }
  } on SocketException catch (_) {
    throw Exception('Connection refused');
  } catch (e) {
    throw Exception('An unexpected error occurred: $e');
  }
}