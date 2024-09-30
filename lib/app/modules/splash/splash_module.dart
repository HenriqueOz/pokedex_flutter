import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/modules/splash/bloc/splash_bloc.dart';
import 'package:pokedex_app/app/modules/splash/splash.dart';
import 'package:pokedex_app/app/repositories/pokemon_name_list_repository.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';
import 'package:provider/provider.dart';

class SplashModule {
  static pageBuilder({required RouteSettings? settings}) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => MultiBlocProvider(
        providers: [
          Provider(
            create: (BuildContext context) => PokemonRepository(),
          ),
          Provider(
            create: (BuildContext context) =>
                PokemonNameListRepository(pokemonRepository: context.read(), sqliteDatabase: context.read()),
          ),
          BlocProvider(create: (BuildContext context) => SplashBloc(pokemonNameListRepository: context.read())..add(SplashLoad())),
        ],
        child: const Splash(),
      ),
    );
  }
}
