import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:pokedex_app/app/core/formatter/formatter.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_color.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class TabTypeChart extends StatelessWidget {
  final List<Map<String, double>> typeChartList;
  final Color primaryColor;

  const TabTypeChart({super.key, required this.typeChartList, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, double>> typeChartListWeaknesses = [];
    final List<Map<String, double>> typeChartListResistances = [];

    //* filtrando a type chart em duas listas
    for (var type in typeChartList) {
      final multiplier = type.entries.first.value;

      if (multiplier < 1) {
        typeChartListResistances.add(type);
      } else if (multiplier > 1) {
        typeChartListWeaknesses.add(type);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weaknesses',
            style: CustomTheme.pokedexLabels.copyWith(color: primaryColor),
          ),
          const SizedBox(height: 20),
          _typeGrid(list: typeChartListWeaknesses),
          Divider(
            height: 20,
            color: primaryColor,
            thickness: .5,
          ),
          const SizedBox(height: 10),
          Text(
            'Resistance',
            style: CustomTheme.pokedexLabels.copyWith(color: primaryColor),
          ),
          const SizedBox(height: 20),
          _typeGrid(list: typeChartListResistances),
          Divider(
            height: 20,
            color: primaryColor,
            thickness: .5,
          ),
        ],
      ),
    );
  }

  Widget _typeGrid({required List<Map<String, double>> list}) {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final type = list[index].entries.first.key;
        final multiplier = list[index].entries.first.value;

        return _typeCard(label: type, multiplier: multiplier);
      },
    );
  }

  Widget _typeCard({required String label, required double multiplier}) {
    final Color color = PokemonTypeColor.colors[label]!;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Text(
            Formatter.captalize(text: label),
            textAlign: TextAlign.center,
            style: CustomTheme.pokedexLabels.copyWith(fontSize: 13),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '${multiplier.toFraction()}x',
        ),
      ],
    );
  }
}
