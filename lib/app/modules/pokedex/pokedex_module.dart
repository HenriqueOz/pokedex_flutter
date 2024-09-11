import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: unused_import
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/pokedex_page.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';
import 'package:provider/provider.dart';

class PokedexModule {
  final routers = <String, WidgetBuilder>{
    '/pokedex/': (BuildContext context) => MultiProvider(
      providers: [
        Provider(create: (context) => PokemonRepository())
      ],
      child: BlocProvider<PokedexBloc>(
        create: (context) => PokedexBloc(pokemonRepository: context.read<PokemonRepository>())..add(PokedexEventLoad(quantity: 5)),
        child: PokedexPage(),
      ),
    ),
  };
}
