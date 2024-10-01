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
      //* retornando um modelo com base no id
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
      //* carregando um pokemon com base no nome
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon-species/$name');

      //* pegando o id da resposta e fazendo um request com base nela
      final id = response.data['id'];
      final responseById = await dio.get('https://pokeapi.co/api/v2/pokemon/$id');

      //* retornando o modelo obtido
      return PokemonModel.fromMap(responseById.data);
    } on Exception catch (e, s) {
      log('Repository: Erro ao carregar feed', error: e, stackTrace: s);
      throw MessageException(message: 'Error while loading item');
    }
  }

  Future<PokemonInfoModel> getPokemonInfoById({required int id}) async {
    try {
      final dio = Dio();
      //* chamando o primeiro request base do pokemon
      final responseStats = await dio.get('https://pokeapi.co/api/v2/pokemon/$id');

      //* salvando a specie dele
      final specieName = responseStats.data['species']['name'];

      //* fazendo outro request com base nessa specie
      final responseDescription = await dio.get('https://pokeapi.co/api/v2/pokemon-species/$specieName');

      //* adcionando os dados obtidos no map que será entregue para o modelo
      final Map<String, dynamic> map = {};
      map.addAll(responseStats.data);
      map.addAll(responseDescription.data);

      //* armazenando a url da evolution chain e fazendo um request com ela
      final String evolutionChainUrl = map['evolution_chain']['url'];
      final responseEvolutionChain = await dio.get(evolutionChainUrl);

      //* salvando a resposta
      final chain = responseEvolutionChain.data;

      //* preparando a lista de formas
      final List<String> chainSpecies = [];

      //* adicionadno a forma base
      chainSpecies.add(chain['chain']['species']['name']);

      //* adicionando a lista da segunda forma
      final List<dynamic> secondFormList = chain['chain']['evolves_to'];

      //* navegando na corrente de evoluções do pokemon
      if (secondFormList.isNotEmpty) {
        for (var form in secondFormList) {
          //* adicionando todas as formas secundarias do pokemon na lista
          chainSpecies.add(form['species']['name']);

          //* adicionando todas as formas finais que estão dentro da lista de formas
          //* secundárias formas secundarias na lista
          final List<dynamic> finalFormList = form['evolves_to'];
          if (finalFormList.isNotEmpty) {
            for (var form in finalFormList) {
              chainSpecies.add(form['species']['name']);
            }
          }
        }
      }

      //* adicionando um future de um model para cada forma dentro de uma list
      final listEvolution = chainSpecies.map((name) => getPokemonBySpecies(name: name)).toList();
      final List<PokemonModel> listEvolutionLoaded = [];

      //* se a lista de species tiver mais de um nome, eu faço o fetch do dados presentes, caso contrário
      //* retorno uma lista vazia
      if (chainSpecies.length > 1) {
        final list = await Future.wait(listEvolution).onError((error, stackTrace) => throw Exception());
        listEvolutionLoaded.addAll(list);
      }

      //* carregando a lista de formas variadas do pokemon
      final List<dynamic> varietiesList = map['varieties'];

      //* retornando as formas diferentes da principal
      final List<dynamic> linkList = varietiesList.where(
        (e) {
          return (responseStats.data['name'] != e['pokemon']['name']);
        },
      ).toList();
      //* salvando as urls das formas filtradas
      final List<String> urlList = linkList.map((e) => e['pokemon']['url']).toList().cast<String>();
      final List<PokemonModel> listForms = [];

      //* fazendo um request para cada url na lista
      for (var url in urlList) {
        final response = await dio.get(url);

        //* verificando se a resposta possuí sprites
        final bool hasNormalSprite = response.data['sprites']['other']['official-artwork']['front_default'] != null;
        final bool hasShinySprite = response.data['sprites']['other']['official-artwork']['front_shiny'] != null;

        //* adicioando um model após a verifação na lista
        if (hasNormalSprite && hasShinySprite) {
          listForms.add(PokemonModel.fromMap(response.data));
        }
      }

      //* adicionando as lists no map
      map.addAll(
        {
          'forms_list': listForms,
          'chain_list': listEvolutionLoaded,
        },
      );

      return PokemonInfoModel.fromMap(map);
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
