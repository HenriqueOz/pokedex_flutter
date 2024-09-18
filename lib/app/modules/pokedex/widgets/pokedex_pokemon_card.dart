import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokemon/pokemon_page.dart';

class PokedexPokemonCard extends StatelessWidget {
  final PokemonModel model;

  const PokedexPokemonCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final NumberFormat f = NumberFormat('000');

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return PokemonPage(model: model);
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final tweenIn = Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              );

              return SlideTransition(
                position: tweenIn.animate(animation),
                child: child,
              );
            },
          ),
        );
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
                          '${model.name[0].toUpperCase()}${model.name.substring(1)}',
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
