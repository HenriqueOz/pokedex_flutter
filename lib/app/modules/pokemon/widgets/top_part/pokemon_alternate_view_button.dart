import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/pokemon/bloc/pokemon_view_cubit/pokemon_view_cubit.dart';

class PokemonAlternateViewButton extends StatelessWidget {
  const PokemonAlternateViewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocSelector<PokemonViewCubit, PokemonViewState, bool>(
        selector: (state) {
          if (state is PokemonViewData) {
            return state.shiny;
          }
          return false;
        },
        builder: (context, shiny) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //* botões de alteração da view da thumbnail do pokemon entre normal e shiny
              TextButton(
                onPressed: () {
                  context.read<PokemonViewCubit>().showNorma();
                },
                style: shiny ? CustomTheme.outlinedButton(primaryColor: Colors.white) : CustomTheme.filledButton(primaryColor: Colors.white),
                child: const Text('Normal'),
              ),
              const SizedBox(width: 30),
              TextButton(
                onPressed: () {
                  context.read<PokemonViewCubit>().showShiny();
                },
                style: shiny
                    ? CustomTheme.filledButton(primaryColor: Colors.yellow.shade100)
                    : CustomTheme.outlinedButton(primaryColor: Colors.yellow.shade100),
                child: const Text('Shiny'),
              ),
            ],
          );
        },
      ),
    );
  }
}
