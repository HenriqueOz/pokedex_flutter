import 'package:pokedex_app/app/core/pokemon_data/pokemon_generation_enum.dart';

class PokemonGenrationLimits {
  static int offset = 0;
  static int limit = 1;

  static void setGenerationRange(PokemonGenerationEnum generation) {
    switch (generation) {
      case PokemonGenerationEnum.gen1:
        offset = 0;
        limit = 151;
        break;
      case PokemonGenerationEnum.gen2:
        offset = 151;
        limit = 100;
        break;
      case PokemonGenerationEnum.gen3:
        offset = 251;
        limit = 135;
        break;
      case PokemonGenerationEnum.gen4:
        offset = 386;
        limit = 107;
        break;
      case PokemonGenerationEnum.gen5:
        offset = 493;
        limit = 156;
        break;
      case PokemonGenerationEnum.gen6:
        offset = 649;
        limit = 72;
        break;
      case PokemonGenerationEnum.gen7:
        offset = 721;
        limit = 88;
        break;
      case PokemonGenerationEnum.gen8:
        offset = 809;
        limit = 96;
        break;
      case PokemonGenerationEnum.gen9:
        offset = 915;
        limit = 120;
        break;
    }
  }
}
