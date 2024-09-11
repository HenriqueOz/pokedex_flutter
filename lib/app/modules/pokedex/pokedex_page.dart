import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/pokedex_appbar.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/pokedex_header.dart';

class PokedexPage extends StatelessWidget {
  bool loading = false;

  PokedexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PokedexAppbar(),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(), //* Precisa disso aqui pra definir como scroll padrão
        child: Column(
          children: [
            const SizedBox(
              height: 36,
            ),
            const PokedexHeader(),
            BlocSelector<PokedexBloc, PokedexState, bool>(
              selector: (state) {
                if (state is PokedexStateLoading) {
                  return true;
                }
                return false;
              },
              builder: (context, loading) {
                return Visibility(
                  visible: loading,
                  child: CircularProgressIndicator(),
                );
              },
            ),
            BlocSelector<PokedexBloc, PokedexState, List<PokemonModel>>(
              selector: (state) {
                if (state is PokedexStateFetchPokemon) {
                  return state.pokemonModelList;
                }
                return <PokemonModel>[];
              },
              builder: (context, pokemonModelList) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(), //* Desligando o scroll da ListView
                  shrinkWrap: true, //* ListView com o tamanho necessário
                  itemCount: pokemonModelList.length,
                  itemBuilder: (context, index) {
                    final pokemonModel = pokemonModelList[index];

                    return Text(pokemonModel.name);
                  },
                );
              },
            ),
            Visibility(
              visible: loading,
              child: const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
