import 'package:flutter/material.dart';
import 'package:it_fox_test/core/di/app_locator.dart';
import 'package:it_fox_test/main.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLocator.getItInit();
  await AppLocator.hiveInit();

  const devConfig = FlavorConfig(
    flavorName: 'dev',
    child: MyApp(),
  );

  runApp(devConfig);
}
