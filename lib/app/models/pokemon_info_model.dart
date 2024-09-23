class PokemonInfoModel {
  final Map<String, int> stats;
  final Map<String, dynamic> description;
  final Map<String, String?> cries;

  PokemonInfoModel({required this.stats, required this.description, required this.cries});

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

    //* Pegando a description do map
    final Map<String, dynamic> description = {
      'height': map['height'] as int?,
      'weight': map['weight'] as int?,
      'base_happiness': map['base_happiness'] as int?,
      'capture_rate': map['capture_rate'] as int?,
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
    );
  }

  @override
  String toString() {
    String statsString = '';
    String descString = '';
    String criesString = '';

    for (var item in stats.entries) {
      statsString += (' ${item.key}: ${item.value}\n');
    }

    for (var item in description.entries) {
      descString += (' ${item.key}: ${item.value}\n');
    }

    for (var item in cries.entries) {
      criesString += (' ${item.key}: ${item.value}\n');
    }

    return 'PokemonInfoModel\nstats:\n$statsString\ndescription:\n$descString\ncries:\n$criesString';
  }
}
