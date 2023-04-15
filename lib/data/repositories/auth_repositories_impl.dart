import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:it_fox_test/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _apiKey = 'cef311b3965116d22980baa2ecf4f777';
  final _autorizedUser = 'test@test.org';

  @override
  Future<String> logIn({
    required String username,
    required String password,
  }) async {
    if (username == _autorizedUser) return _apiKey;

    throw Exception('User not found');
  }

  @override
  Future<void> logOut() async {
    //
    return;
  }
}

class TokenRepositoryImpl implements TokenRepository {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  @override
  Future<void> deleteToken() async => await _storage.delete(key: 'apiKey');

  @override
  Future<String?> readToken() async => await _storage.read(key: 'apiKey');

  @override
  Future<void> writeToken(String token) async {
    return await _storage.write(key: 'apiKey', value: token);
  }
}
