import 'package:get_it/get_it.dart';
import 'package:it_fox_test/core/widgets/error_overlay.dart';
import 'package:it_fox_test/domain/repositories/auth_repository.dart';

class AuthUsecase {
  final AuthRepository _authRepository = GetIt.I.get();
  final TokenRepository _tokenRepository = GetIt.I.get();

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final token = await _authRepository.logIn(
        username: username,
        password: password,
      );

      await _tokenRepository.writeToken(token);
    } catch (e) {
      showError((e).toString());
    }
  }

  Future<void> logOut() async => await _tokenRepository.deleteToken();

  Future<bool> hasToken() async {
    final token = await _tokenRepository.readToken();
    return (token?.isNotEmpty ?? false);
  }
}
