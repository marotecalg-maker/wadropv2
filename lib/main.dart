import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final storage = await StorageService.create();
  runApp(WadropApp(storage: storage));
}
