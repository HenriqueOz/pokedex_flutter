import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokemon/pokemon_page.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';
import 'package:provider/provider.dart';

class PokemonModule {
  static final routers = {
    '/pokemon/': (BuildContext context) {
      final PokemonModel model = ModalRoute.of(context)?.settings.arguments as PokemonModel;

      return MultiBlocProvider(
        providers: [
          Provider(create: (context) => PokemonRepository()),
        ],
        child: PokemonPage(model: model),
      );
    },
  };
}
