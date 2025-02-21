import 'dart:convert';

import 'package:la27mobile/config/constants.dart';
import 'package:la27mobile/domain/datasources/tuips_datasource.dart';
import 'package:la27mobile/domain/entities/tuip.dart';
import 'package:la27mobile/infrastructure/models/tuip_model.dart';
import 'package:la27mobile/infrastructure/storage/auth_storage.dart';
import 'package:http/http.dart' as http;

class TuipsDatasourceImp implements TuipsDatasource {
  final storage = AuthStorage();

  @override
  Future<Tuip> getTuip({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Tuip>> getTuips({required int page, required int limit}) async {
    final token = await storage.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    final response = await http
        .get(Uri.parse('$domain/api/tuips?page=$page,limit=$limit'), headers: {
      'Demon-Token': token,
    });

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => TuipModel.fromJson(json).toTuipEntity())
          .toList();
    } else {
      throw Exception('Failed to load self user data');
    }
  }
}
