import 'package:la27mobile/domain/entities/login.dart';
import 'package:la27mobile/domain/entities/register.dart';

abstract class LoginRegisterRepository {
  Future<void> login({required Login login});
  Future<void> register({required Register register});
}
