import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fraction/fraction.dart';
import 'package:pokedex_app/app/core/formatter/formatter.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_color.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/type_combination/cubit/type_combination_cubit.dart';

class TypeCombinationChart extends StatelessWidget {
  const TypeCombinationChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TypeCombinationCubit, TypeCombinationState, List<Map<String, double>>>(
      selector: (state) {
        if (state is TypeCombinationFetch) {
          return state.typeChart;
        }
        return [];
      },
      builder: (context, typeChart) {
        final typeChartWeakbesses = typeChart.where((e) => e.entries.first.value > 1).toList();
        final typeChartResistance = typeChart.where((e) => e.entries.first.value < 1).toList();
        final typeChartNormal = typeChart.where((e) => e.entries.first.value == 1).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label(label: 'Weaknesses'),
            _grid(typeChart: typeChartWeakbesses),
            _label(label: 'Normal'),
            _grid(typeChart: typeChartNormal),
            _label(label: 'Resistances'),
            _grid(typeChart: typeChartResistance),
          ],
        );
      },
    );
  }

  Widget _label({required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Text(
        label,
        style: CustomTheme.pokedexLabels.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget _grid({required List<Map<String, double>> typeChart}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: typeChart.length,
      itemBuilder: (context, index) {
        final String name = typeChart[index].entries.first.key;
        final double multiplier = typeChart[index].entries.first.value;

        return _typeCard(label: name, multiplier: multiplier);
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
