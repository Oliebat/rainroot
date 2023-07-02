import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Utils {
  static String baseUrl = 'http://192.168.1.16:8080/api'; //ip maison
  // static String baseUrl = 'http://172.16.0.45:8080/api'; // NFS
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

class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? picture;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      picture: json['picture'],
    );
  }

  // Override toString
  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, email: $email, picture: $picture}';
  }
}

class UserManager {
  final _storage = FlutterSecureStorage();
  static const _userKey = 'UserId';

  Future<void> setUserId(String id) async {
    await _storage.write(key: _userKey, value: id);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: _userKey);
  }
}

class Sprinkler {
  final int sprinklerId;
  final int userId;
  final String uniqueCode;
  final String sprinklerName;
  final String location;
  final double waterLevel;
  final double soilMoistureLevel;
  final double temperature;
  final bool irrigationStatus;
  final dynamic lastIrrigationTime;
  final dynamic scheduledIrrigationTime;
  final bool automaticIrrigation;
  final String createdAt;
  final String updatedAt;

  Sprinkler({
    required this.sprinklerId,
    required this.userId,
    required this.uniqueCode,
    required this.sprinklerName,
    required this.location,
    required this.waterLevel,
    required this.soilMoistureLevel,
    required this.temperature,
    required this.irrigationStatus,
    this.lastIrrigationTime,
    this.scheduledIrrigationTime,
    required this.automaticIrrigation,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sprinkler.fromJson(Map<String, dynamic> json) {
    return Sprinkler(
      sprinklerId: json['sprinkler_id'],
      userId: json['userId'],
      uniqueCode: json['uniqueCode'],
      sprinklerName: json['sprinkler_name'],
      location: json['location'],
      waterLevel: json['water_level'].toDouble(),
      soilMoistureLevel: json['soil_moisture_level'].toDouble(),
      temperature: json['temperature'].toDouble(),
      irrigationStatus: json['irrigation_status'],
      lastIrrigationTime: json['last_irrigation_time'],
      scheduledIrrigationTime: json['scheduledIrrigationTime'],
      automaticIrrigation: json['automaticIrrigation'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
  @override
  String toString() {
    return 'Sprinkler { sprinklerId: $sprinklerId, userId: $userId, uniqueCode: $uniqueCode, sprinklerName: $sprinklerName, location: $location, waterLevel: $waterLevel, soilMoistureLevel: $soilMoistureLevel, temperature: $temperature, irrigationStatus: $irrigationStatus, lastIrrigationTime: $lastIrrigationTime, scheduledIrrigationTime: $scheduledIrrigationTime, automaticIrrigation: $automaticIrrigation, createdAt: $createdAt, updatedAt: $updatedAt }';
  }
}
