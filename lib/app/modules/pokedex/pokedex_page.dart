import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/pokedex_appbar.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/pokedex_header.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/pokedex_pokemon_card.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  late ScrollController scrollController;
  final bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scroolBottomReached);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scroolBottomReached);
    super.dispose();
  }

  void _scroolBottomReached() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent * .90) {
      context.read<PokedexBloc>().add(PokedexEventLoad());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PokedexAppbar(),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const ScrollPhysics(), //* Precisa disso aqui pra definir como scroll padrão
        child: Column(
          children: [
            const SizedBox(
              height: 36,
            ),
            const PokedexHeader(),
            BlocSelector<PokedexBloc, PokedexState, List<PokemonModel>>(
              selector: (state) {
                if (state is PokedexStateLoading) {
                  return state.pokemonModelListHolder;
                }

                if (state is PokedexStateFetchPokemon) {
                  return state.pokemonModelList;
                }

                return <PokemonModel>[];
              },
              builder: (context, pokemonModelList) {
                final orientation = MediaQuery.of(context).orientation;
                final gridCrossAxisCount = orientation == Orientation.portrait ? 2 : 3;

                return Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridCrossAxisCount,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 16,
                    ),
                    physics:
                        const NeverScrollableScrollPhysics(), //* Desligando o scroll da ListView
                    shrinkWrap: true, //* ListView com o tamanho necessário
                    itemCount: pokemonModelList.length,
                    itemBuilder: (context, index) {
                      return PokedexPokemonCard(model: pokemonModelList[index]);
                    },
                  ),
                );
              },
            ),
            BlocSelector<PokedexBloc, PokedexState, bool>(
              selector: (state) {
                return (state is PokedexStateLoading);
              },
              builder: (context, isLoading) {
                return Visibility(
                  visible: isLoading,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: const CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
