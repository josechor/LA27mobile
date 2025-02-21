import 'package:la27mobile/domain/entities/login.dart';
import 'package:la27mobile/domain/entities/register.dart';

abstract class LoginRegisterDatasource {
  Future<String?> login({required Login login});
  Future<void> register({required Register register});
}
