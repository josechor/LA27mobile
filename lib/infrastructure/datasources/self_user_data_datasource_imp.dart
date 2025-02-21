import 'dart:convert';

import 'package:la27mobile/config/constants.dart';
import 'package:la27mobile/domain/datasources/self_user_data_datasource.dart';
import 'package:la27mobile/domain/entities/self_user_data.dart';
import 'package:http/http.dart' as http;
import 'package:la27mobile/infrastructure/models/self_user_data_model.dart';
import 'package:la27mobile/infrastructure/storage/auth_storage.dart';

class SelfUserDataDatasourceImp implements SelfUserDataDatasource {
  final storage = AuthStorage();
  @override
  Future<SelfUserData> getSelfUserData() async {
    final token = await storage.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    final response =
        await http.get(Uri.parse('$domain/api/users/userData'), headers: {
      'Demon-Token': token,
    });

    if (response.statusCode == 200) {
      return SelfUserDataModel.fromJson(json.decode(response.body))
          .toVideoPostEntity();
    } else {
      throw Exception('Failed to load self user data');
    }
  }
}
