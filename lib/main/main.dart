import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/externals/db/db_scheme.dart';
import 'package:verymemo/externals/db/db_service.dart';
import 'package:verymemo/features/lifecycle/app_lifecycle_wrapper.dart';
import 'package:verymemo/firebase_options.dart';
import 'package:verymemo/main/app.dart';

final dbContainer = ProviderContainer();

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final dbInit = dbContainer.read(dbServiceProvider).initDB(dbSchemes);
  await dbInit;

  print("mainCommon call");

  runApp(ProviderScope(child: AppLifecycleWrapper(child: App())));
}
