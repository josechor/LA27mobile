import 'package:la27mobile/domain/datasources/tuips_datasource.dart';
import 'package:la27mobile/domain/entities/tuip.dart';
import 'package:la27mobile/domain/repositories/tuips_repository.dart';

class TuipsRepositoryImp implements TuipsRepository {
  final TuipsDatasource datasource;

  TuipsRepositoryImp({
    required this.datasource,
  });

  @override
  Future<Tuip> getTuip({required int id}) async {
    return await datasource.getTuip(id: id);
  }

  @override
  Future<List<Tuip>> getTuips({required int page, required int limit}) async {
    return await datasource.getTuips(page: page, limit: limit);
  }

  @override
  Future<void> setLike({required int tuipId}) async {
    return await datasource.setLike(tuipId: tuipId);
  }

  @override
  Future<void> removeLike({required int tuipId}) async {
    return await datasource.removeLike(tuipId: tuipId);
  }
}
