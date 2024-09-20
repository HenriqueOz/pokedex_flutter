import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokemon/bloc/pokemon_info_bloc.dart';
import 'package:pokedex_app/app/modules/pokemon/cubit/pokemon_view_cubit.dart';
import 'package:pokedex_app/app/modules/pokemon/pokemon_page.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';
import 'package:provider/provider.dart';

class PokemonModule {
  static pageBuilder({required PokemonModel model}) {
    return MultiBlocProvider(
      providers: [
        Provider(create: (BuildContext context) => PokemonRepository()),
        BlocProvider(create: (BuildContext context) => PokemonViewCubit()),
        BlocProvider(
            create: (BuildContext context) => PokemonInfoBloc(pokemonRepository: RepositoryProvider.of(context))..add(PokemonInfoLoad(id: model.id)))
      ],
      child: PokemonPage(model: model),
    );
  }
}
