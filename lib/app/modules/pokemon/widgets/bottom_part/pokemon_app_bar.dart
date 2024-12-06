import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/modules/pokemon/bloc/pokemon_favorite_cubit/pokemon_favorite_cubit.dart';

class PokemonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int modelId;

  const PokemonAppBar({super.key, required this.modelId});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      actions: [
        BlocSelector<PokemonFavoriteCubit, PokemonFavoriteState, bool>(
          selector: (state) {
            if (state is PokemonFavoriteFetch) {
              return state.isFavorite;
            }
            return false;
          },
          builder: (context, isFavorite) {
            return IconButton(
              onPressed: () {
                if (isFavorite) {
                  context.read<PokemonFavoriteCubit>().removeFavorite(id: modelId);
                } else {
                  context.read<PokemonFavoriteCubit>().addFavorite(id: modelId);
                }
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 25,
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/pokedex/'));
            },
            icon: const Icon(
              Icons.home,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
