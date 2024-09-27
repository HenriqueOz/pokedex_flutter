import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: unused_import
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_scroll_bloc/pokedex_scroll_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_list_bloc/pokedex_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_search_bloc/pokedex_search_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/pokedex_page.dart';
import 'package:pokedex_app/app/repositories/pokemon_name_list_repository.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';
import 'package:provider/provider.dart';

class PokedexModule {
  static pageBuilder({required RouteSettings? settings}) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => MultiBlocProvider(
        providers: [
          Provider(create: (context) => PokemonRepository()),
          Provider(create: (context) => PokemonNameListRepository(pokemonRepository: context.read(), sqliteDatabase: context.read())),
          BlocProvider(create: (context) => PokedexBloc(pokemonRepository: context.read<PokemonRepository>())..add(PokedexEventLoad())),
          BlocProvider(create: (context) => PokedexScrollBloc()),
          BlocProvider(create: (context) => PokedexSearchBloc(pokemonNameListRepository: context.read())),
        ],
        child: const PokedexPage(),
      ),
    );
  }
}
