import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokedex_app/app/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  Hive.init(dir.path);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const AppModule());
}
