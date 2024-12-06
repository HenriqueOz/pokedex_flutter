import 'dart:convert';

class PokemonNameListModel {
  final List<String> nameList;
  PokemonNameListModel({
    required this.nameList,
  });

  PokemonNameListModel copyWith({
    List<String>? nameList,
  }) {
    return PokemonNameListModel(
      nameList: nameList ?? this.nameList,
    );
  }

  factory PokemonNameListModel.fromMap(Map<String, dynamic> map) {
    return PokemonNameListModel(
      nameList: map['results'].map((e) => e['name']).toList().cast<String>(),
    );
  }

  factory PokemonNameListModel.fromJson(String source) => PokemonNameListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PokemonNameListModel(nameList: $nameList)';
}
