import 'package:dio/dio.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';

class PokemonRepository {

  Future<PokemonModel> getPokemonById({required int id}) async {
    //! Fazer o tratamento do id

    final dio = Dio();
    final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$id');

    return PokemonModel.fromMap(response.data);
  }

}