import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokedex_app/app/core/database/sqlite_database.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_count.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';

class PokemonNameListRepository {
  int _count = 0;
  final PokemonRepository _pokemonRepository;

  PokemonNameListRepository({required PokemonRepository pokemonRepository}) : _pokemonRepository = pokemonRepository;

  Future<bool> isNameListLoaded() async {
    final db = SqliteDatabase.createInstance();
    final conn = await db.openConnection();

    final res = await conn.rawQuery('''
      SELECT COUNT(pokemon_id) FROM pokemon_name
    ''');

    final String numberString = res.first['COUNT(pokemon_id)'].toString();
    _count = int.parse(numberString);

    await conn.close();
    db.closeConnection();

    return _count == PokemonCount.count;
  }

  Future<void> loadNameList() async {
    final bool loaded = await isNameListLoaded();

    if (!loaded) {
      if (_count > PokemonCount.count) {
        deleteNameList();
      }

      final int begin = _count;
      final int end = PokemonCount.count - begin;

      final model = await _pokemonRepository.getPokemonNameListModel(
        begin,
        end,
      );

      final db = SqliteDatabase.createInstance();
      final conn = await db.openConnection();
      int items = 0;

      debugPrint('--------------------- Adding elements to pokemon_names');
      for (var name in model.nameList) {
        // * Top 10 filmes de terror: Sqlite e o for maldito
        await conn.execute('INSERT INTO pokemon_name VALUES (null, ?)', [name]);
        items++;
      }
      debugPrint('--------------------- Insert done in pokemon_names');
      debugPrint('--------------------- $items items added');

      await conn.close();
      db.closeConnection();
    }
  }

  Future<void> deleteNameList() async {
    final db = SqliteDatabase.createInstance();
    final conn = await db.openConnection();
    conn.rawDelete('Delete * from pokemon_name');

    await conn.close();
    db.closeConnection();

    debugPrint('------------------------ pokemon_name table clear');
  }

  Future<List<String>> searchInNameList(String name) async {
    final db = SqliteDatabase.createInstance();
    final conn = await db.openConnection();

    final result = await conn.rawQuery('SELECT name FROM pokemon_name WHERE name LIKE ? || "%"', [name]);

    final List<String> list = result.map((e) => e['name']).toList().cast<String>();

    debugPrint('$list');
    return list;
  }
}
