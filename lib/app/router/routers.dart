import 'package:flutter/material.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/models/user_model.dart';
import 'package:pokedex_app/app/modules/edit_profile/edit_profile_module.dart';
import 'package:pokedex_app/app/modules/favorites/favorites_module.dart';
import 'package:pokedex_app/app/modules/pokedex/pokedex_module.dart';
import 'package:pokedex_app/app/modules/pokemon/pokemon_module.dart';
import 'package:pokedex_app/app/modules/splash/splash_module.dart';
import 'package:pokedex_app/app/modules/type_combination/type_combination_module.dart';

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

      case ('/type_combination/'):
        return TypeCombinationModule.pageBuilder(settings: settings);

      case ('/edit_profile/'):
        final UserModel user = settings?.arguments as UserModel;

        return EditProfileModule.pageBuilder(settings: settings, user: user);

      case ('/favorites/'):
        return FavoritesModule.pageBuilder(settings: settings, context: context);
    }
    return null;
  }
}
