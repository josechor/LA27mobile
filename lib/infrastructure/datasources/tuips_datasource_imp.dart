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
  Future<Tuip> getTuip({required int id}) async {
    final token = await storage.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    final response =
        await http.get(Uri.parse('$domain/api/tuips/$id'), headers: {
      'Demon-Token': token,
    });

    if (response.statusCode == 200) {
      return TuipModel.fromJson(json.decode(response.body)).toTuipEntity();
    } else {
      throw Exception('Failed to load self user data');
    }
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

  @override
  Future<void> setLike({required int tuipId}) async {
    try {
      final token = await storage.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      await http.post(
        Uri.parse('$domain/api/tuips/like/$tuipId'),
        headers: {
          'Demon-Token': token,
        },
      );
    } catch (e) {
      throw Exception('Failed to like $e');
    }
  }

  @override
  Future<void> removeLike({required int tuipId}) async {
    try {
      final token = await storage.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      await http.delete(Uri.parse('$domain/api/tuips/like/$tuipId'), headers: {
        'Demon-Token': token,
      });
    } catch (e) {
      throw Exception('Failed to like $e');
    }
  }
}
