import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/bottom_part/pokemon_variations_list.dart';

class TabForms extends StatelessWidget {
  final List<PokemonModel> list;
  final Color primaryColor;
  final PokemonModel mainModel;

  const TabForms({super.key, required this.mainModel, required this.list, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final model = list[index];

                return PokemonVariationsList(mainModel: mainModel, model: model);
              },
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(
              "${mainModel.name} doesn't have forms",
              style: CustomTheme.pokedexLabels.copyWith(
                color: mainModel.primaryColor!,
              ),
            ),
          );
  }
}
