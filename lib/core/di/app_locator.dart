import 'package:get_it/get_it.dart';

class AppLocator {
  static void init() {
    final getIt = GetIt.I;
  }

  static Future<void> dispose() async {
    return GetIt.I.reset();
  }
}
