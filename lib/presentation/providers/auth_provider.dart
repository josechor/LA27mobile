import 'package:flutter/material.dart';
import 'package:la27mobile/domain/entities/login.dart';
import 'package:la27mobile/domain/entities/self_user_data.dart';
import 'package:la27mobile/infrastructure/datasources/login_register_datasource_imp.dart';
import 'package:la27mobile/infrastructure/datasources/self_user_data_datasource_imp.dart';
import 'package:la27mobile/infrastructure/repositories/login_register_repository_imp.dart';
import 'package:la27mobile/infrastructure/repositories/self_user_data_repository_imp.dart';
import 'package:la27mobile/infrastructure/storage/auth_storage.dart';

class AuthProvider extends ChangeNotifier {
  final AuthStorage _authStorage = AuthStorage();
  final SelfUserDataRepositoryImp _userDataSource =
      SelfUserDataRepositoryImp(datasource: SelfUserDataDatasourceImp());
  final LoginRegisterRepositoryImp _loginRegisterSource =
      LoginRegisterRepositoryImp(datasource: LoginRegisterDatasourceImp());

  String? _token;
  SelfUserData? _userData;
  bool _isLoading = true;

  String? get token => _token;
  SelfUserData? get userData => _userData;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    _token = await _authStorage.getToken();
    if (_token != null) {
      try {
        _userData = await _userDataSource.getSelfUserData();
      } catch (e) {
        _token = null;
        await _authStorage.removeToken();
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getSelfData(String token) async {
    await _authStorage.saveToken(token);
    _token = token;
    try {
      _userData = await _userDataSource.getSelfUserData();
    } catch (e) {
      _token = null;
      await _authStorage.removeToken();
    }
    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final String? token = await _loginRegisterSource.login(
          login: Login(email: email, password: password));
      await getSelfData(token!);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _token = null;
      _userData = null;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authStorage.removeToken();
    _token = null;
    _userData = null;
    notifyListeners();
  }
}
