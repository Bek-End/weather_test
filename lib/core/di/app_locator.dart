import 'package:get_it/get_it.dart';
import 'package:it_fox_test/data/repositories/auth_repositories_impl.dart';
import 'package:it_fox_test/domain/repositories/auth_repository.dart';
import 'package:it_fox_test/domain/usecases/auth.usecase.dart';
import 'package:it_fox_test/presentation/auth/bloc/auth_bloc.dart';

class AppLocator {
  static void init() {
    final getIt = GetIt.I;

    getIt.registerSingleton<TokenRepository>(TokenRepositoryImpl());
    getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
    getIt.registerSingleton<AuthUsecase>(AuthUsecase());
    getIt.registerSingleton<AuthBloc>(AuthBloc());
  }

  static Future<void> dispose() async {
    return GetIt.I.reset();
  }
}
