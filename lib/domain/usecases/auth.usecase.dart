import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get_it/get_it.dart';
import 'package:it_fox_test/core/widgets/error_overlay.dart';
import 'package:it_fox_test/domain/repositories/auth_repository.dart';
import 'package:it_fox_test/domain/repositories/local_data_repository.dart';

class AuthUsecase {
  final AuthRepository _authRepository = GetIt.I.get();
  final TokenRepository _tokenRepository = GetIt.I.get();
  final LocalDataRepository _localDataRepository = GetIt.I.get();

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
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
      showError((e).toString());
    }
  }

  Future<void> logOut() async {
    await _localDataRepository.deleteWeatherRes();
    await _tokenRepository.deleteToken();
  }

  Future<bool> hasToken() async {
    final token = await _tokenRepository.readToken();
    return (token?.isNotEmpty ?? false);
  }
}
