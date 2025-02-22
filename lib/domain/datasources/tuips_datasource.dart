import 'package:la27mobile/domain/entities/tuip.dart';

abstract class TuipsDatasource {
  Future<Tuip> getTuip({required int id});

  Future<List<Tuip>> getTuips({required int page, required int limit});

  Future<void> setLike({required int tuipId});

  Future<void> removeLike({required int tuipId});
}
