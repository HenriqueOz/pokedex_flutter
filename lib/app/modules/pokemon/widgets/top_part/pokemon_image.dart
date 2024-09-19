import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/modules/pokemon/cubit/pokemon_view_cubit.dart';

class PokemonImage extends StatelessWidget {
  final String imageUrl;
  final String shinyImageUrl;

  const PokemonImage({super.key, required this.imageUrl, required this.shinyImageUrl});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: BlocSelector<PokemonViewCubit, PokemonViewState, String>(
        selector: (state) {
          if (state is PokemonViewData) {
            if (state.shiny) {
              return shinyImageUrl;
            } else {
              return imageUrl;
            }
          }
          return imageUrl;
        },
        builder: (context, url) {
          return CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) {
              return Image.asset('assets/images/loading.gif');
            },
            height: 475,
          );
        },
      ),
    );
  }
}
