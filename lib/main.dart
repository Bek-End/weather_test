import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:it_fox_test/core/di/app_locator.dart';
import 'package:it_fox_test/core/di/bloc_scope.dart';
import 'package:it_fox_test/firebase_options.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

late GlobalKey<NavigatorState> globalKey;

class FlavorConfig extends StatelessWidget {
  const FlavorConfig({
    required this.flavorName,
    required this.child,
    super.key,
  });

  final String flavorName;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLocator.getItInit();
  await AppLocator.hiveInit();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await messaging.getToken(
    vapidKey: "BLcgGKwloLIUi_JcvEkFmr4Bjvu1XxogDamoUILKZ5ygVh5ba95byTaFp8NsSYCzxFp8i6WCpS9eiYQv9-OuNvM",
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runZonedGuarded(() => runApp(const MyApp()), (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
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
