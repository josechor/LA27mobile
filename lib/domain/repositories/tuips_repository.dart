import 'package:la27mobile/domain/entities/post_tuip.dart';
import 'package:la27mobile/domain/entities/tuip.dart';

abstract class TuipsRepository {
  Future<Tuip> getTuip({required int id});

  Future<List<Tuip>> getTuips({required int page, required int limit});

  Future<void> postTuip({required PostTuip tuip});

  Future<void> setLike({required int tuipId});

  Future<void> removeLike({required int tuipId});
}
