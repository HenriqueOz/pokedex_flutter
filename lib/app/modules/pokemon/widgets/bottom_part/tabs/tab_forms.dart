import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/formatter/formatter.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/bottom_part/pokemon_variations_list.dart';

class TabForms extends StatefulWidget {
  final List<PokemonModel> list;
  final Color primaryColor;
  final PokemonModel mainModel;

  const TabForms({super.key, required this.mainModel, required this.list, required this.primaryColor});

  @override
  State<TabForms> createState() => _TabFormsState();
}

class _TabFormsState extends State<TabForms> {

  @override
  void didChangeDependencies() {
    for (var element in widget.list) {
      precacheImage(CachedNetworkImageProvider(element.imageUrl), context);
      precacheImage(CachedNetworkImageProvider(element.shinyImageUrl), context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.list.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                final model = widget.list[index];

                return PokemonVariationsList(mainModel: widget.mainModel, model: model);
              },
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(
              "${Formatter.captalize(text: widget.mainModel.name)} doesn't have forms",
              textAlign: TextAlign.center,
              style: CustomTheme.pokedexLabels.copyWith(
                color: widget.mainModel.primaryColor!,
              ),
            ),
          );
  }
}
