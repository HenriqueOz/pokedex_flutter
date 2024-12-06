import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pokedex_app/app/core/database/sqlite_database.dart';
import 'package:pokedex_app/app/core/exceptions/message_exception.dart';
import 'package:pokedex_app/app/models/pokemon_info_model.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/models/pokemon_name_list_model.dart';

class PokemonRepository {
  final SqliteDatabase _sqliteDatabase;

  PokemonRepository({required SqliteDatabase sqliteDatabase}) : _sqliteDatabase = sqliteDatabase;

  Future<PokemonModel> getPokemonById({required int id}) async {
    try {
      final dio = Dio();
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$id');

      if (response.statusCode == 200) {
        return PokemonModel.fromMap(response.data);
      } else {
        throw Exception();
      }
    } on Exception catch (e, s) {
      log('Repository: Erro ao carregar feed', error: e, stackTrace: s);
      throw MessageException(message: 'Error while loading feed');
    }
  }

  Future<PokemonModel> getPokemonBySpecies({required String name}) async {
    try {
      final dio = Dio();
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon-species/$name');

      final id = response.data['id'];
      final responseById = await dio.get('https://pokeapi.co/api/v2/pokemon/$id');

      return PokemonModel.fromMap(responseById.data);
    } on Exception catch (e, s) {
      log('Repository: Erro ao carregar feed', error: e, stackTrace: s);
      throw MessageException(message: 'Error while loading item');
    }
  }

  Future<PokemonInfoModel> getPokemonInfoById({required int id}) async {
    try {
      final dio = Dio();
      final responseStats = await dio.get('https://pokeapi.co/api/v2/pokemon/$id');

      final specieName = responseStats.data['species']['name'];

      final responseDescription = await dio.get('https://pokeapi.co/api/v2/pokemon-species/$specieName');

      final Map<String, dynamic> pokemonData = {};
      pokemonData.addAll(responseStats.data);
      pokemonData.addAll(responseDescription.data);

      final String evolutionChainUrl = pokemonData['evolution_chain']['url'];
      final responseEvolutionChain = await dio.get(evolutionChainUrl);

      final chain = responseEvolutionChain.data;

      final List<String> evolutionList = [];
      evolutionList.add(chain['chain']['species']['name']); //* adicionando a forma base do pokemon

      final List<dynamic> secondFormList = chain['chain']['evolves_to'];

      if (secondFormList.isNotEmpty) {
        for (var form in secondFormList) {
          evolutionList.add(form['species']['name']);

          final List<dynamic> finalFormList = form['evolves_to'];
          if (finalFormList.isNotEmpty) {
            for (var form in finalFormList) {
              evolutionList.add(form['species']['name']);
            }
          }
        }
      }

      final modelRequestList = evolutionList.map((name) => getPokemonBySpecies(name: name)).toList();
      final List<PokemonModel> modelList = [];

      if (evolutionList.length > 1) {
        final list = await Future.wait(modelRequestList).onError((error, stackTrace) => throw Exception());
        modelList.addAll(list);
      }

      final List<dynamic> varietiesList = pokemonData['varieties'];

      final List<dynamic> varietiesPokemonList = varietiesList.where(
        (e) {
          return (responseStats.data['name'] != e['pokemon']['name']);
        },
      ).toList();
      final List<String> urlList = varietiesPokemonList.map((e) => e['pokemon']['url']).toList().cast<String>();

      final List<PokemonModel> formsList = [];

      for (var url in urlList) {
        final response = await dio.get(url);

        final bool hasNormalSprite = response.data['sprites']['other']['official-artwork']['front_default'] != null;
        final bool hasShinySprite = response.data['sprites']['other']['official-artwork']['front_shiny'] != null;

        if (hasNormalSprite && hasShinySprite) {
          formsList.add(PokemonModel.fromMap(response.data));
        }
      }

      pokemonData.addAll(
        {
          'forms_list': formsList,
          'chain_list': modelList,
        },
      );

      return PokemonInfoModel.fromMap(pokemonData);
    } on Exception catch (e, s) {
      const String message = 'Error while loading data';
      log(message, error: e, stackTrace: s);
      throw MessageException(message: message);
    }
  }

  Future<PokemonNameListModel> getPokemonNameListModel(int begin, int end) async {
    try {
      //* retornando uma lista de nomes com base em um offset e um limit (quantidade de nomes que serão carregados)
      final dio = Dio();
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon?limit=$end&offset=$begin');

      if (response.statusCode == 200) {
        return PokemonNameListModel.fromMap(response.data);
      } else {
        throw Exception();
      }
    } on Exception catch (e, s) {
      const String message = 'Error while loading data';
      log(message, error: e, stackTrace: s);
      throw MessageException(message: message);
    }
  }

  Future<PokemonModel> searchPokemonByName({required String name}) async {
    try {
      //* carregando um modelo com base no nome entregue
      final dio = Dio();
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$name');

      return PokemonModel.fromMap(response.data);
    } on Exception catch (e, s) {
      log('Repository: Erro ao carregar feed', error: e, stackTrace: s);
      throw MessageException(message: 'Error while loading item');
    }
  }

  Future<void> addFavoriteById({required int id}) async {
    try {
      final conn = await _sqliteDatabase.openConnection();
      await conn.rawInsert('INSERT INTO favorite VALUES (null, ?)', [id]);
    } catch (e, s) {
      log('Erro ao adicionar favorito', error: e, stackTrace: s);
      throw MessageException(message: 'Error while loading data');
    }
  }

  Future<void> removeFavoriteById({required int id}) async {
    try {
      final conn = await _sqliteDatabase.openConnection();

      await conn.rawInsert('DELETE FROM favorite WHERE pokedex_id = ?', [id]);
    } catch (e, s) {
      log('Erro ao remover favorito', error: e, stackTrace: s);
      throw MessageException(message: 'Error while loading data');
    }
  }

  Future<bool> getFavoriteById({required int id}) async {
    try {
      final conn = await _sqliteDatabase.openConnection();

      final res = await conn.rawQuery('SELECT * FROM favorite WHERE pokedex_id = ?', [id]);
      return res.isNotEmpty;
    } catch (e, s) {
      log('Erro ao remover favorito', error: e, stackTrace: s);
      throw MessageException(message: 'Error while loading data');
    }
  }

  Future<List<int>> getFavoriteList() async {
    try {
      final conn = await _sqliteDatabase.openConnection();

      final res = await conn.rawQuery('SELECT pokedex_id FROM favorite ORDER BY pokedex_id');
      debugPrint('---------------------- Getting favorite list');

      final List<int> list = [];

      for (var value in res) {
        final entry = value.entries.first;
        list.add(entry.value as int);
      }

      return list;
    } catch (e, s) {
      log('Erro buscars lista de favoritos', error: e, stackTrace: s);
      throw MessageException(message: 'Error while loading data');
    }
  }
}
