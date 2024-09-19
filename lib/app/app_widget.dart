import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokemon/pokemon_module.dart';
import 'package:pokedex_app/app/router/router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.themeData,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case ('/pokemon/'):
            final PokemonModel model = settings.arguments as PokemonModel;

            return PageTransition(
              child: PokemonModule.pageBuilder(model: model),
              type: PageTransitionType.bottomToTop,
            );
        }
        return null;
      },
      routes: {...Routers().routers},
    );
  }
}
