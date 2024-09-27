import 'package:pokedex_app/app/core/pokemon_data/pokemon_type_chart.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_types.dart';

class PokemonTypeChartCalc {
  static List<Map<String, double>> calcTypeChart({required String primaryType, required String? secondaryType}) {
    final Map<String, double> primaryTypeMap = PokemonTypeChart.typeChart[primaryType]!;
    final Map<String, double> secondaryTypeMap = {};

    if (secondaryType != null) {
      secondaryTypeMap.addAll(PokemonTypeChart.typeChart[secondaryType]!);
    }

    final typeList = [...PokemonTypes.types];
    final typeChartList = <Map<String, double>>[];

    for (var type in typeList) {
      double multiplier = 1;

      if (primaryTypeMap[type] != null) {
        multiplier *= primaryTypeMap[type]!;
      }

      if (secondaryTypeMap[type] != null) {
        multiplier *= secondaryTypeMap[type]!;
      }

      typeChartList.add(
        {
          type: multiplier,
        },
      );
    }

    // debugPrint('${typeChartMap.toString()}\n');

    return typeChartList;
  }
}
