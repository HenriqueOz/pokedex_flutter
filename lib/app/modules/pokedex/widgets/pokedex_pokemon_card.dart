import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';

class PokedexPokemonCard extends StatelessWidget {
  final PokemonModel model;

  const PokedexPokemonCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final NumberFormat f = NumberFormat('000');

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 160,
        minHeight: 130,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: model.primaryColor,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey,
                )
              ],
            ),
            child: Stack(
              children: [
                //* Background do card
                Image.asset(
                  'assets/images/card_background.png',
                  height: constraints.minHeight,
                ),
                //* Nome do pokemon
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${model.name[0].toUpperCase()}${model.name.substring(1)}',
                    style: CustomTheme.pokedexLabels,
                  ),
                ),
                //* Tipo(s) do pokemon
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      Image.asset(
                        model.typePrimaryIconUrl,
                        width: 20,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      () {
                        if (model.typeSecondary != null) {
                          return Image.asset(
                            model.typeSecondaryIconUrl!,
                            width: 20,
                          );
                        }
                        return const SizedBox.shrink();
                      }(),
                    ],
                  ),
                ),
                //* Número da pokedéx
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '#${f.format(model.id)}',
                    style: CustomTheme.pokedexLabels,
                  ),
                ),
                //* Imagem do pokemon
                Align(
                  alignment: Alignment.center,
                  child: Image.network(
                    model.imageUrl,
                    height: constraints.maxHeight - 40,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
