import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_generation_enum.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_list_bloc/pokedex_bloc.dart';

class PokedexGenFilter extends StatelessWidget {
  final PokemonGenerationEnum selectedGeneration;

  const PokedexGenFilter({required this.selectedGeneration, super.key});

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
                  style: selectedGeneration == PokemonGenerationEnum.values[index]
                      ? CustomTheme.secondaryButton.copyWith(
                          backgroundColor: const WidgetStatePropertyAll(CustomTheme.secondaryColor),
                          foregroundColor: const WidgetStatePropertyAll(Colors.white),
                        )
                      : CustomTheme.secondaryButton,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('Gen ${index + 1}'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
