import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/database/sqlite_database.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_count.dart';

class Initializer {
  Future<bool> isNameListLoaded() async {
    final db = SqliteDatabase.createInstance();
    final conn = await db.openConnection();

    final res = await conn.rawQuery('''
      SELECT COUNT(pokemon_id) FROM pokemon_name
    ''');

    if (res.first.toString() != PokemonCount.count.toString()) {
      deleteNameList();

      //! Chamar meu repository no context
      // fazer o carregamento da lista de nomes

      loadNameList();
    }

    return false;
  }

  Future<void> loadNameList() async {}

  Future<void> deleteNameList() async {
    final conn = await SqliteDatabase.createInstance().openConnection();
    conn.rawDelete('Delete * from pokemon_name');

    debugPrint('------------------------ pokemon_name table clear');
  }
}
