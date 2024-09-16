import 'package:dio/dio.dart';
import 'package:pokedex_app/app/core/exceptions/message_exception.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';

class PokemonRepository {
  /// Procura um pokemon a partir de seu id na pokedéx
  Future<PokemonModel> getPokemonById({required int id}) async {
    try {
      final dio = Dio();
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$id');

      if (response.statusCode == 200) {
        return PokemonModel.fromMap(response.data);
      }
    } on Exception {
      MessageException(message: 'Erro ao carregar item');
    }

    return PokemonModel(
      id: 000,
      name: 'MissingNo.',
      typePrimary: 'normal',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/MissingNo.svg/1200px-MissingNo.svg.png',
    );
  }
}
