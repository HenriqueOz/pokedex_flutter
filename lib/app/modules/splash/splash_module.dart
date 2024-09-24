import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/modules/splash/splash.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';
import 'package:provider/provider.dart';

class SplashModule {
  static pageBuilder() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MultiBlocProvider(
        providers: [
          Provider(
            create: (BuildContext context) => PokemonRepository(),
          )
        ],
        child: const Splash(),
      ),
    );
  }
}
