import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:it_fox_test/core/di/app_locator.dart';
import 'package:it_fox_test/firebase_options.dart';
import 'package:it_fox_test/main.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLocator.getItInit();
  await AppLocator.hiveInit();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await messaging.getToken(
    vapidKey: "BLcgGKwloLIUi_JcvEkFmr4Bjvu1XxogDamoUILKZ5ygVh5ba95byTaFp8NsSYCzxFp8i6WCpS9eiYQv9-OuNvM",
  );

  const prodConfig = FlavorConfig(
    flavorName: 'prod',
    child: MyApp(),
  );

  runZonedGuarded(() => runApp(prodConfig), (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}
