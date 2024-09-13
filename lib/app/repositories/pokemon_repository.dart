import 'package:dio/dio.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';

class PokemonRepository {
  /// Procura um pokemon a partir de seu id na pokedéx
  Future<PokemonModel> getPokemonById({required int id}) async {
    //! Fazer o tratamento do id

    final dio = Dio();
    final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$id');

    if (response.statusCode == 200) {
      return PokemonModel.fromMap(response.data);
    }
    return PokemonModel(
      id: 000,
      name: 'MissingNo.',
      typePrimary: 'normal',
      imageUrl: 'https://pokemonet.fandom.com/pt-br/wiki/Missingno',
    );
  }
}
