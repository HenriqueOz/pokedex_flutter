import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex_app/app/core/formatter/formatter.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/core/ui/messenger.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';

class PokemonVariationsList extends StatelessWidget {
  final PokemonModel mainModel;
  final PokemonModel model;

  const PokemonVariationsList({super.key, required this.mainModel, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      //* card
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 10,
            )
          ],
        ),
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: InkWell(
            onTap: () {
              if (mainModel.name != model.name) {
                Navigator.pushNamed(context, '/pokemon/', arguments: model);
              } else {
                Messenger.of(context).showMessage("You are currently on this page", Colors.white, model.primaryColor!);
              }
            },
            splashColor: model.primaryColor?.withOpacity(.2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  //* thumbnail do pokemon
                  SizedBox(
                    width: 120,
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Image.asset('assets/images/loading.gif'),
                      fit: BoxFit.cover,
                      imageUrl: model.imageUrl,
                    ),
                  ),
                  //* nome e tipos
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* nome e id
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                Formatter.captalize(text: model.name),
                                style: CustomTheme.pokedexLabels.copyWith(
                                  color: model.primaryColor,
                                ),
                              ),
                            ),
                            //* só mostro o id do pokemon se ele for válido
                            () {
                              if (model.id < 10000) {
                                return Text(' #${NumberFormat('000').format(model.id)}');
                              }
                              return const SizedBox.shrink();
                            }(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      //* tipos
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              color: model.primaryColor,
                            ),
                            child: Text(
                              Formatter.captalize(text: model.typePrimary),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              color: model.secondaryColor,
                            ),
                            child: Text(
                              Formatter.captalize(text: model.typeSecondary ?? ''),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
