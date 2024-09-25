import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokedex_app/app/core/database/sqlite_database.dart';
import 'package:pokedex_app/app/core/exceptions/message_exception.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_count.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';

class PokemonNameListRepository {
  int _count = 0;
  final PokemonRepository _pokemonRepository;

  PokemonNameListRepository({required PokemonRepository pokemonRepository}) : _pokemonRepository = pokemonRepository;

  Future<bool> isNameListLoaded() async {
    final db = SqliteDatabase.createInstance();
    final conn = await db.openConnection();

    try {
      final res = await conn.rawQuery('''
        SELECT COUNT(pokemon_id) FROM pokemon_name
      ''');

      final String numberString = res.first['COUNT(pokemon_id)'].toString();
      _count = int.parse(numberString);

      return _count == PokemonCount.count;
    } on Exception catch (e, s) {
      const String message = 'Erro ao carregar dados';
      log('Erro ao verificar estado da lista de nomes', error: e, stackTrace: s);
      throw MessageException(message: message);
    } finally {
      await conn.close();
      db.closeConnection();
    }
  }

  Future<void> loadNameList() async {
    final db = SqliteDatabase.createInstance();
    final conn = await db.openConnection();

    try {
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

        int items = 0;

        debugPrint('--------------------- Adding elements to pokemon_names');
        for (var name in model.nameList) {
          // * Top 10 filmes de terror: Sqlite e o for maldito
          await conn.execute('INSERT INTO pokemon_name VALUES (null, ?)', [name]);
          items++;
        }
        debugPrint('--------------------- Insert done in pokemon_names');
        debugPrint('--------------------- $items items added');
      }
    } on Exception catch (e, s) {
      const String message = 'Error while loading data';
      log('Erro ao carregar lista de nomes', error: e, stackTrace: s);
      throw MessageException(message: message);
    } finally {
      await conn.close();
      db.closeConnection();
    }
  }

  Future<void> deleteNameList() async {
    final db = SqliteDatabase.createInstance();
    final conn = await db.openConnection();
    try {
      conn.rawDelete('Delete * from pokemon_name');

      debugPrint('------------------------ pokemon_name table clear');
    } on Exception catch (e, s) {
      const String message = 'Error while loading data';
      log('Erro ao limpar lista de nomes', error: e, stackTrace: s);
      throw MessageException(message: message);
    } finally {
      await conn.close();
      db.closeConnection();
    }
  }

  Future<List<String>> searchInNameList(String name) async {
    final db = SqliteDatabase.createInstance();
    final conn = await db.openConnection();

    try {
      final result = await conn.rawQuery('SELECT name FROM pokemon_name WHERE name LIKE ? || "%"', [name]);

      final List<String> list = result.map((e) => e['name']).toList().cast<String>();

      debugPrint('$list');
      return list;
    } on Exception catch (e, s) {
      const String message = 'Error while searching';
      log('Erro ao buscar na lista de nomes', error: e, stackTrace: s);
      throw MessageException(message: message);
    } finally {
      await conn.close();
      db.closeConnection();
    }
  }
}
