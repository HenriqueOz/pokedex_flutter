import 'package:flutter/material.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokedex/pokedex_module.dart';
import 'package:pokedex_app/app/modules/pokemon/pokemon_module.dart';
import 'package:pokedex_app/app/modules/splash/splash_module.dart';

class Routers {
  //* instância que cuida das rotas
  static onGenerateRoutes(RouteSettings? settings, BuildContext context) {
    switch (settings?.name) {
      case ('/'):
        return SplashModule.pageBuilder(settings: settings); //* passar settings para funções de navegação com nome funcionarem

      case ('/pokedex/'):
        return PokedexModule.pageBuilder(settings: settings);

      case ('/pokemon/'):
        final PokemonModel model = settings?.arguments as PokemonModel;

        return PokemonModule.pageBuilder(settings: settings, context: context, model: model);
    }
    return null;
  }
}
