import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokedex_app/app/modules/favorites/bloc/favorites_bloc.dart';
import 'package:pokedex_app/app/modules/favorites/favorites_page.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';
import 'package:provider/provider.dart';

class FavoritesModule {
  static Route pageBuilder({required RouteSettings? settings, required BuildContext context}) {
    return PageTransition(
      type: PageTransitionType.rightToLeft,
      child: MultiBlocProvider(
        providers: [
          Provider(
            lazy: false,
            create: (BuildContext context) => PokemonRepository(sqliteDatabase: context.read()),
          ),
          BlocProvider(
            create: (BuildContext context) => FavoritesBloc(pokemonRepository: context.read())..add(FavoritesLoad()),
          ),
        ],
        child: const FavoritesPage(),
      ),
    );
  }
}
