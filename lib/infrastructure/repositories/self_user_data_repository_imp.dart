import 'package:la27mobile/domain/datasources/self_user_data_datasource.dart';
import 'package:la27mobile/domain/entities/self_user_data.dart';
import 'package:la27mobile/domain/repositories/self_user_data_repository.dart';

class SelfUserDataRepositoryImp implements SelfUserDataRepository {
  final SelfUserDataDatasource datasource;

  SelfUserDataRepositoryImp({
    required this.datasource,
  });

  @override
  Future<SelfUserData> getSelfUserData() {
    return datasource.getSelfUserData();
  }
}
