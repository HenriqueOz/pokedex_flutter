enum PokemonGenerationBounds {
  gen1(offset: 0, limit: 151),
  gen2(offset: 151, limit: 100),
  gen3(offset: 251, limit: 135),
  gen4(offset: 386, limit: 107),
  gen5(offset: 493, limit: 156),
  gen6(offset: 649, limit: 72),
  gen7(offset: 721, limit: 88),
  gen8(offset: 809, limit: 96),
  gen9(offset: 905, limit: 120);

  const PokemonGenerationBounds({required this.offset, required this.limit});
  final int offset;
  final int limit;
}
