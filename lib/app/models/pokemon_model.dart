import 'dart:ui';

import 'package:pokedex_app/app/core/pokemon_data/pokemon_color.dart';

class PokemonModel {
  final int id;
  final String name;
  final String typePrimary;
  String? typeSecondary;
  final String imageUrl;
  final String shinyImageUrl;
  final String typePrimaryIconUrl;
  String? typeSecondaryIconUrl;
  Color? primaryColor;
  Color? secondaryColor;

  PokemonModel({
    required this.id,
    required this.name,
    required this.typePrimary,
    this.typeSecondary,
    required this.imageUrl,
    required this.shinyImageUrl,
  })  : typePrimaryIconUrl = 'assets/images/types/${typePrimary}_type_icon.png', //* definindo a url do icon primário
        primaryColor = PokemonTypeColor.colors[typePrimary]; //* defindo a cor primária com base no tipo primário entregue no constructor

  PokemonModel copyWith({
    int? id,
    String? name,
    String? typePrimary,
    String? typeSecondary,
    String? imageUrl,
    String? shinyImageUrl,
  }) {
    return PokemonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      typePrimary: typePrimary ?? this.typePrimary,
      typeSecondary: typeSecondary ?? this.typeSecondary,
      imageUrl: imageUrl ?? this.imageUrl,
      shinyImageUrl: shinyImageUrl ?? this.shinyImageUrl,
    );
  }

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    final model = PokemonModel(
      id: map['id'] as int,
      name: map['name'] as String,
      typePrimary: map['types'][0]['type']['name'] as String,
      imageUrl: map['sprites']['other']['official-artwork']['front_default'] as String,
      shinyImageUrl: map['sprites']['other']['official-artwork']['front_shiny'] as String,
    );

    //* se o pokemon tiver mais de um tipo, eu atribuo os valores do tipo secundário as varáveis da instância
    if (map['types'].length > 1) {
      model.typeSecondary = map['types'][1]['type']['name'] as String;
      model.typeSecondaryIconUrl = 'assets/images/types/${model.typeSecondary}_type_icon.png';
      model.secondaryColor = PokemonTypeColor.colors[model.typeSecondary];
    }

    return model;
  }

  factory PokemonModel.fromSqlite(Map<String, Object?> map) {
    final model = PokemonModel(
      id: map['pokedex_id'] as int,
      name: map['name'] as String,
      typePrimary: map['type_primary'] as String,
      typeSecondary: map['type_secondary'] as String?,
      imageUrl: map['image_url'] as String,
      shinyImageUrl: map['shiny_image_url'] as String,
    );

    if (model.typeSecondary != null) {
      model.typeSecondaryIconUrl = 'assets/images/types/${model.typeSecondary}_type_icon.png';
      model.secondaryColor = PokemonTypeColor.colors[model.typeSecondary];
    }

    return model;
  }

  @override
  String toString() {
    return '''
    PokemonModel(
      id: $id,
      name: $name,
      typePrimary: $typePrimary,
      typeSecondary: $typeSecondary,
      imageUrl: $imageUrl,
      shinyImageUrl: $shinyImageUrl,
      typePrimaryIconUrl: $typePrimaryIconUrl,
      typeSecondaryIconUrl: $typeSecondaryIconUrl,
      primaryColor: $primaryColor,
      secondaryColor: $secondaryColor,
    )''';
  }
}
