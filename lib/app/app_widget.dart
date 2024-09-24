import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/router/routers.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.themeData,
      initialRoute: '/',
      onGenerateRoute: (settings) => Routers.onGenerateRoutes(settings, context),
    );
  }
}
