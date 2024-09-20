import 'package:flutter/material.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/top_part/pokemon_alternate_view_button.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/bottom_part/pokemon_app_bar.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/top_part/pokemon_backgroud.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/bottom_part/pokemon_bottom_card.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/top_part/pokemon_image.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/top_part/pokemon_left_label.dart';

class PokemonPage extends StatelessWidget {
  final PokemonModel model;

  const PokemonPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            model.primaryColor ?? Colors.white,
            Colors.grey.shade700,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PokemonAppBar(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //* Parte superior
                SizedBox(
                  height: MediaQuery.of(context).size.height * .25,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        //* Background
                        const PokemonBackgroud(),
                        //* Imagem do pokemon
                        PokemonImage(imageUrl: model.imageUrl, shinyImageUrl: model.shinyImageUrl),
                        //* Label da esquerda com o nome do pokemon
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            constraints: BoxConstraints(maxHeight: constraints.maxHeight * .3),
                            child: PokemonLeftLabel(name: model.name),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //* Botões
                const PokemonAlternateViewButton(),
                //* Card de informações
                PokemonBottomCard(model: model),
              ],
            );
          },
        ),
      ),
    );
  }
}
