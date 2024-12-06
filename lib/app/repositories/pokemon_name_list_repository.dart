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
  final SqliteDatabase _sqliteDatabase;

  PokemonNameListRepository({required PokemonRepository pokemonRepository, required SqliteDatabase sqliteDatabase})
      : _pokemonRepository = pokemonRepository,
        _sqliteDatabase = sqliteDatabase;

  Future<bool> isNameListLoaded() async {
    try {
      final conn = await _sqliteDatabase.openConnection();

      final res = await conn.rawQuery('''
        SELECT COUNT(pokemon_id) FROM pokemon_name
      ''');

      final String numberString = res.first['COUNT(pokemon_id)'].toString();
      _count = int.parse(numberString);

      debugPrint('------------------------- count pokemon_name: $_count');

      return _count == PokemonCount.count;
    } on Exception catch (e, s) {
      const String message = 'Erro ao carregar dados';
      log('Erro ao verificar estado da lista de nomes', error: e, stackTrace: s);
      throw MessageException(message: message);
    }
  }

  Future<void> loadNameList() async {
    try {
      final bool loaded = await isNameListLoaded();

      if (!loaded) {
        if (_count > PokemonCount.count) {
          deleteNameList();
        }

        final int offset = _count;
        final int limit = PokemonCount.count - offset;

        final model = await _pokemonRepository.getPokemonNameListModel(
          offset,
          limit,
        );

        int items = 0;

        final conn = await _sqliteDatabase.openConnection();

        debugPrint('--------------------- Adding elements to pokemon_names');

        for (var name in model.nameList) {
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
    }
  }

  Future<void> deleteNameList() async {
    try {
      final conn = await _sqliteDatabase.openConnection();

      conn.rawDelete('DELETE FROM pokemon_name');
      _count = 0;

      debugPrint('------------------------ pokemon_name table clear');
    } on Exception catch (e, s) {
      const String message = 'Error while loading data';
      log('Erro ao limpar lista de nomes', error: e, stackTrace: s);
      throw MessageException(message: message);
    }
  }

  Future<List<String>> searchInNameList(String name) async {
    try {
      final conn = await _sqliteDatabase.openConnection();

      final result = await conn.rawQuery('SELECT name FROM pokemon_name WHERE name LIKE ? || "%"', [name]);

      final List<String> list = result.map((e) => e['name']).toList().cast<String>();

      debugPrint('$list');
      return list;
    } on Exception catch (e, s) {
      const String message = 'Error while searching';
      log('Erro ao buscar na lista de nomes', error: e, stackTrace: s);
      throw MessageException(message: message);
    }
  }
}
