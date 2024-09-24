import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pokedex_app/app/core/exceptions/message_exception.dart';
import 'package:pokedex_app/app/models/pokemon_info_model.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/models/pokemon_name_list_model.dart';

class PokemonRepository {
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
      throw MessageException(message: 'Erro ao carregar feed');
    }
  }

  Future<PokemonInfoModel> getPokemonInfoById({required int id}) async {
    try {
      final dio = Dio();
      final responseStats = dio.get('https://pokeapi.co/api/v2/pokemon/$id');
      final responseDescription = dio.get('https://pokeapi.co/api/v2/pokemon-species/$id');

      final responses = await Future.wait([responseStats, responseDescription]).onError((e, s) {
        throw Exception();
      });

      final Map<String, dynamic> map = {};
      for (var response in responses) {
        map.addAll(response.data);
      }
      return PokemonInfoModel.fromMap(map);
    } on Exception catch (e, s) {
      const String message = 'Erro ao carregar informações';
      log(message, error: e, stackTrace: s);
      throw MessageException(message: message);
    }
  }

  Future<PokemonNameListModel> getPokemonNameListModel(int begin, int end) async {
    try {
      final dio = Dio();
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon?limit=$end&offset=$begin');

      if (response.statusCode == 200) {
        return PokemonNameListModel.fromMap(response.data);
      } else {
        throw Exception();
      }
    } on Exception catch (e, s) {
      const String message = 'Erro ao carregar informações';
      log(message, error: e, stackTrace: s);
      throw MessageException(message: message);
    }
  }
}
