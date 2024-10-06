import 'package:pokedex_app/app/models/pokemon_model.dart';

class PokemonInfoModel {
  final Map<String, int> stats;
  final Map<String, dynamic> description;
  final Map<String, String?> cries;
  final List<PokemonModel> forms;
  final List<PokemonModel> evolutionChain;

  PokemonInfoModel({required this.stats, required this.description, required this.cries, required this.evolutionChain, required this.forms});
  factory PokemonInfoModel.empty() {
    return PokemonInfoModel(
      stats: {},
      description: {},
      cries: {},
      evolutionChain: [],
      forms: [],
    );
  }

  factory PokemonInfoModel.fromMap(Map<String, dynamic> map) {
    //* Pegandos os stats no map
    final List<int> statsValues = map['stats'].map((value) => value['base_stat']).toList().cast<int>();
    final List<String> statsNames = map['stats'].map((value) => value['stat']['name']).toList().cast<String>();
    final Map<String, int> stats = {};

    for (int i = 0; i < statsValues.length; i++) {
      stats[statsNames[i]] = statsValues[i];
    }

    //* Pegando os cries
    final Map<String, String?> cries = {
      'latest': map['cries']['latest'] as String?,
      'legacy': map['cries']['legacy'] as String?,
    };

    //* pegando a evolution chain
    final List<PokemonModel> evolutionChain = map['chain_list'];

    //* pegando as formas
    final List<PokemonModel> forms = map['forms_list'];

    //* Pegando a description do map
    final Map<String, dynamic> description = {
      'generation': map['generation']['name'] as String,
      'height': map['height'] as int?,
      'weight': map['weight'] as int?,
      'base_happiness': map['base_happiness'] as int?,
      'capture_rate': map['capture_rate'] as int?,
      'evolution_chain': map['evolution_chain']['url'] as String,
      'pokedex_entry': () {
        // * filtrando os resultados de entries por somente os que tiverem em ingles
        final List<dynamic> nameList = map['flavor_text_entries'].where((e) => e['language']['name'] == 'en').toList();
        // pegando o resultado mais recente (último da lista)
        String? entry = nameList.last['flavor_text'];
        // removendo a formatação que vem no texto
        entry = entry?.replaceAll('\n', ' ');
        return entry;
      }(),
    };

    return PokemonInfoModel(
      stats: stats,
      description: description,
      cries: cries,
      evolutionChain: evolutionChain,
      forms: forms,
    );
  }

  @override
  String toString() {
    return '''
    PokemonInfoModel(
      \ndescription:\n${description.toString().replaceAll(',', '\n')}
      \nstats:\n${stats.toString().replaceAll(',', '\n')}
      \ncries:\n${cries.toString().replaceAll(',', '\n')}
      \nevolutionChain:\n${evolutionChain.toString().replaceAll(',', '\n')}
      \nforms:\n${forms.toString().replaceAll(',', '\n')}
    )''';
  }
}
