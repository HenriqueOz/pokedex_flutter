import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex_app/app/app_module.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const AppModule());
}
