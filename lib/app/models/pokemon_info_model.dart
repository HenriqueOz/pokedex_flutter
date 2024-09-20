class PokemonInfoModel {
  final Map<String, int> stats;
  final Map<String, dynamic> description;

  PokemonInfoModel({required this.stats, required this.description});

  factory PokemonInfoModel.fromMap(Map<String, dynamic> map) {
    //* Pegandos os stats no map
    final List<int> statsValues = map['stats'].map((value) => value['base_stat']).toList().cast<int>();
    final List<String> statsNames = map['stats'].map((value) => value['stat']['name']).toList().cast<String>();

    final Map<String, int> stats = {};

    for (int i = 0; i < statsValues.length; i++) {
      stats[statsNames[i]] = statsValues[i];
    }

    //* Pegando a description do map
    final Map<String, dynamic> description = {
      'height': map['height'] as int?,
      'weight': map['weight'] as int?,
      'base_happiness': map['base_happiness'] as int?,
      'capture_rate': map['capture_rate'] as int?,
      'pokedex_entry': map['flavor_text_entries'][0]['flavor_text'] as String?,
    };

    return PokemonInfoModel(
      stats: stats,
      description: description,
    );
  }

  @override
  String toString() {
    return '''
    PokemonInfoModel(
      stats: ${stats.toString()},
      description: ${description.toString()},
    )''';
  }
}
