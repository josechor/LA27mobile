import 'package:la27mobile/domain/datasources/login_register_datasource.dart';
import 'package:la27mobile/domain/entities/login.dart';
import 'package:la27mobile/domain/entities/register.dart';
import 'package:la27mobile/domain/repositories/login_register_repository.dart';

class LoginRegisterRepositoryImp implements LoginRegisterRepository {
  final LoginRegisterDatasource datasource;

  LoginRegisterRepositoryImp({
    required this.datasource,
  });

  @override
  Future<String?> login({required Login login}) async {
    return await datasource.login(login: login);
  }

  @override
  Future<void> register({required Register register}) async {
    datasource.register(register: register);
  }
}
