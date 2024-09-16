import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_generation_enum.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_list_bloc/pokedex_bloc.dart';

class PokedexGenFilter extends StatelessWidget {
  PokemonGenerationEnum selectedGeneration;

  PokedexGenFilter({required this.selectedGeneration, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int index = 0; index < PokemonGenerationEnum.values.length; index++)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextButton(
                  onPressed: () {
                    context.read<PokedexBloc>().add(
                          PokedexEventChangeGen(generation: PokemonGenerationEnum.values[index]),
                        );
                  },
                  style: CustomTheme.primaryButton.copyWith(
                    backgroundColor: WidgetStatePropertyAll(
                      selectedGeneration == PokemonGenerationEnum.values[index] ? Colors.red : Colors.transparent,
                    ),
                  ),
                  child: Text('Gen ${index + 1}'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
