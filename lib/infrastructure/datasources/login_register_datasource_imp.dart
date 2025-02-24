import 'dart:convert';

import 'package:la27mobile/config/constants.dart';
import 'package:la27mobile/domain/datasources/login_register_datasource.dart';
import 'package:la27mobile/domain/entities/login.dart';
import 'package:la27mobile/domain/entities/register.dart';
import 'package:http/http.dart' as http;

class LoginRegisterDatasourceImp implements LoginRegisterDatasource {
  @override
  Future<String?> login({required Login login}) async {
    try {
      final response = await http.post(
        Uri.parse('$domain/api/users/auth'),
        body: {
          'email': login.email,
          'password': login.password,
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String token = data['token'];
        return token;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> register({required Register register}) async {
    final response = await http.post(
      Uri.parse('$domain/api/users'),
      body: json.encode({
        'demonName': register.demonName,
        'email': register.email,
        'password': register.password,
        'userName': register.userName,
      }),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to login');
    }
  }
}
