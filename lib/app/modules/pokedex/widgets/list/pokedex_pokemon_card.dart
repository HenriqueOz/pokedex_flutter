import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex_app/app/core/formatter/formatter.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';

class PokedexPokemonCard extends StatelessWidget {
  final PokemonModel model;

  const PokedexPokemonCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final NumberFormat f = NumberFormat('000');

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/pokemon/', arguments: model);
      },
      child: ConstrainedBox(
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
                    child: Container(
                      constraints: BoxConstraints(maxWidth: constraints.maxWidth - 40),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          Formatter.captalize(text: model.name),
                          style: CustomTheme.pokedexLabels,
                        ),
                      ),
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
                        //* retornando um widget para o segundo tipo do pokemon
                        //* somente se ele não for null
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
                    child: model.id < 10000
                        ? Text(
                            '#${f.format(model.id)}',
                            style: CustomTheme.pokedexLabels,
                          )
                        : const Text(
                            'Form',
                            style: CustomTheme.pokedexLabels,
                          ),
                  ),
                  //* Imagem do pokemon
                  Align(
                    alignment: Alignment.center,
                    child: () {
                      if (model.id == 0) {
                        return Image.asset(
                          model.imageUrl,
                          height: constraints.maxHeight - 40,
                        );
                      } else {
                        return CachedNetworkImage(
                          imageUrl: model.imageUrl,
                          placeholder: (context, url) => Image.asset('assets/images/loading.gif'),
                          height: constraints.maxHeight - 40,
                        );
                      }
                    }(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
