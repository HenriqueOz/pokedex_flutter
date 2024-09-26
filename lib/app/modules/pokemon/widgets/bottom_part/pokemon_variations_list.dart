import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokedex_app/app/core/formatter/formatter.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';

class PokemonVariationsList extends StatelessWidget {
  final PokemonModel mainModel;
  final PokemonModel model;

  const PokemonVariationsList({super.key, required this.mainModel, required this.model});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: InkWell(
        onTap: () {
          if (mainModel.name != model.name) {
            Navigator.pushNamed(context, '/pokemon/', arguments: model);
          }
        },
        splashColor: model.primaryColor?.withOpacity(.2),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: model.primaryColor!,
                width: .5,
              ),
            ),
          ),
          child: Row(
            // textDirection: index % 2 != 0 ? TextDirection.rtl : TextDirection.ltr,
            children: [
              SizedBox(
                width: 120,
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset('assets/images/loading.gif'),
                  fit: BoxFit.cover,
                  imageUrl: model.imageUrl,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        Formatter.captalize(text: model.name),
                        style: CustomTheme.pokedexLabels.copyWith(
                          color: model.primaryColor,
                        ),
                      ),
                      Text(' #${NumberFormat('000').format(model.id)}'),
                    ],
                  ),
                  const SizedBox(height: 10),
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
    );
  }
}
