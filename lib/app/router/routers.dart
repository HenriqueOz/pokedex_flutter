import 'package:flutter/material.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokedex/pokedex_module.dart';
import 'package:pokedex_app/app/modules/pokemon/pokemon_module.dart';
import 'package:pokedex_app/app/modules/splash/splash_module.dart';

class Routers {
  static onGenerateRoutes(RouteSettings? settings, BuildContext context) {
    switch (settings?.name) {
      case ('/'):
        return SplashModule.pageBuilder();

      case ('/pokedex/'):
        return PokedexModule.pageBuilder();

      case ('/pokemon/'):
        final PokemonModel model = settings?.arguments as PokemonModel;

        return PokemonModule.pageBuilder(context: context, model: model);
    }
    return null;
  }
}
