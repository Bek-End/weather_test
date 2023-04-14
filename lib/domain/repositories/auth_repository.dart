abstract class AuthRepository {
  Future<String> logIn({
    required String username,
    required String password,
  });

  Future<void> logOut();
}

abstract class TokenRepository {
  /// Возвращает последний кэшированный токен.
  ///
  /// Возвращает null, если токен не кэширован.
  Future<String?> readToken();

  Future<void> writeToken(String token);

  Future<void> deleteToken();
}
