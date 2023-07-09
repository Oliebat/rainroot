// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rainroot/data/apiClient/api_client.dart' as api;
import 'package:rainroot/main.dart';


void main() {
  test('User login test', () async {
    // Provide valid login credentials
    final email = 'test.flutter@example.com';
    final password = 'password123';

    // Call the userLogin function
    final response = await api.userLogin(email, password);

    // Print the response
    print('Response: $response');

    // Verify the response
    expect(response, isNotNull);
    expect(response.containsKey('error'), isFalse);
    expect(response.containsKey('accessToken'), isTrue);
  });
}