import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:it_fox_test/core/di/app_locator.dart';
import 'package:it_fox_test/core/di/bloc_scope.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

late GlobalKey<NavigatorState> globalKey;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLocator.getItInit();
  await AppLocator.hiveInit();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    globalKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT Fox test',
      navigatorKey: globalKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const BlocScope(),
    );
  }
}
