import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pokedex_app/app/core/exceptions/message_exception.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';

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
}
