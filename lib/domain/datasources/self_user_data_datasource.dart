import 'package:la27mobile/domain/entities/self_user_data.dart';

abstract class SelfUserDataDatasource {
  Future<SelfUserData> getSelfUserData();
}
