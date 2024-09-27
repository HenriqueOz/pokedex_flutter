import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_generation_enum.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_list_bloc/pokedex_bloc.dart';

class PokedexGenFilter extends StatelessWidget {
  final PokemonGenerationBounds selectedGeneration;

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
            //* looping para construir um botão para cada valor no meu enum de gerações
            for (int index = 0; index < PokemonGenerationBounds.values.length; index++)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextButton(
                  //* quando pressionando dispara um evento de filtro de geração no bloc
                  onPressed: () {
                    context.read<PokedexBloc>().add(
                          PokedexEventChangeGen(generation: PokemonGenerationBounds.values[index]),
                        );
                  },
                  //* alternando o tema do botão com base na seleção dele
                  style: selectedGeneration == PokemonGenerationBounds.values[index]
                      ? CustomTheme.secondaryButton.copyWith(
                          backgroundColor: const WidgetStatePropertyAll(CustomTheme.secondaryColor),
                          foregroundColor: const WidgetStatePropertyAll(Colors.white),
                        )
                      : CustomTheme.secondaryButton,
                  //* label do botão
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
