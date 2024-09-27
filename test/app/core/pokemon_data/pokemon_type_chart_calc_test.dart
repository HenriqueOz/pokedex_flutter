import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_type_chart_calc.dart';

void main() {
  group(
    PokemonTypeChartCalc,
    () {
      test(
        'return a map with resistance and weaknesses of a pokemon',
        () {
          PokemonTypeChartCalc.calcTypeChart(primaryType: 'fire', secondaryType: 'ghost');
        },
      );
    },
  );
}
