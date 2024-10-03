import 'package:pokedex_app/app/core/pokemon_data/pokemon_type_chart.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_types.dart';

class PokemonTypeChartCalc {
  static List<Map<String, double>> calcTypeChart({required String? primaryType, required String? secondaryType}) {
    final Map<String, double> primaryTypeMap = {};
    final Map<String, double> secondaryTypeMap = {};

    if (primaryType != null || secondaryType != null) {
      if (primaryType != null) {
        primaryTypeMap.addAll(PokemonTypeChart.typeChart[primaryType]!);
      }

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

      typeChartList.sort(
        (t1, t2) {
          var multiplier1 = t1.entries.first.value;
          var multiplier2 = t2.entries.first.value;

          return multiplier2.compareTo(multiplier1);
        },
      );
      // debugPrint('${typeChartMap.toString()}\n');

      return typeChartList;
    }
    return [];
  }
}
