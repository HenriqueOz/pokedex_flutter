// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:pokedex_app/app/core/pokemon_data/pokemon_color.dart';

class PokemonModel {
  final int id;
  final String name;
  final String typePrimary;
  String? typeSecondary;
  final String imageUrl;
  final String typePrimaryIconUrl;
  String? typeSecondaryIconUrl;
  Color? primaryColor;

  PokemonModel({
    required this.id,
    required this.name,
    required this.typePrimary,
    this.typeSecondary,
    required this.imageUrl,
  })  : typePrimaryIconUrl = 'assets/images/types/${typePrimary}_type_icon.png',
        primaryColor = PokemonColor.primaryColor[typePrimary];

  PokemonModel copyWith({
    int? id,
    String? name,
    String? typePrimary,
    String? typeSecondary,
    String? imageUrl,
  }) {
    return PokemonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      typePrimary: typePrimary ?? this.typePrimary,
      typeSecondary: typeSecondary ?? this.typeSecondary,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    final model = PokemonModel(
      id: map['id'] as int,
      name: map['name'] as String,
      typePrimary: map['types'][0]['type']['name'] as String,
      imageUrl: map['sprites']['other']['official-artwork']['front_default'] as String,
    );

    if (map['types'].length > 1) {
      model.typeSecondary = map['types'][1]['type']['name'] as String;
      model.typeSecondaryIconUrl = 'assets/images/types/${model.typeSecondary}_type_icon.png';
    }

    return model;
  }

  factory PokemonModel.fromJson(String source) =>
      PokemonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  //* Modelo que retorna um MissingNo (Ufffff Referências)
  factory PokemonModel.missingNo() => PokemonModel(
        id: 000,
        name: 'MissingNo.',
        typePrimary: 'undefined',
        typeSecondary: 'undefined',
        imageUrl:
            'https://static.wikia.nocookie.net/pokemontowerdefense/images/c/ce/Missingno_image.png/revision/latest?cb=20180809204127',
      );

  @override
  String toString() {
    return 'PokemonModel(id: $id, name: $name, typePrimary: $typePrimary, typeSecondary: $typeSecondary, imageUrl: $imageUrl, typePrimaryIconUrl: $typePrimaryIconUrl, typeSecondaryIconUrl: $typeSecondaryIconUrl)';
  }

  @override
  bool operator ==(covariant PokemonModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.typePrimary == typePrimary &&
        other.typeSecondary == typeSecondary &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        typePrimary.hashCode ^
        typeSecondary.hashCode ^
        imageUrl.hashCode;
  }
}
