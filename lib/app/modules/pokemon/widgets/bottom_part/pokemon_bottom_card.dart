import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/bottom_part/pokemon_info_tab_bar.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/bottom_part/pokemon_type_cards.dart';

class PokemonBottomCard extends StatelessWidget {
  final PokemonModel model;

  const PokemonBottomCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat('000');
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.grey.shade700,
              spreadRadius: 1,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#${f.format(model.id)}',
                    style: CustomTheme.title.copyWith(color: model.primaryColor, fontSize: 30),
                  ),
                  //* Tipos
                  PokemonTypesIcons(
                    primaryColor: model.primaryColor!,
                    typePrimary: model.typePrimary,
                    secondaryColor: model.secondaryColor,
                    typeSecondary: model.typeSecondary,
                  ),
                ],
              ),
              Divider(
                color: model.primaryColor,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                height: 40,
              ),
              PokemonInfoTabBar(color: model.primaryColor!),
            ],
          ),
        ),
      ),
    );
  }
}
