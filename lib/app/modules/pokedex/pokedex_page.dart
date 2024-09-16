import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_generation_enum.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_scroll_bloc/pokedex_scroll_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_list_bloc/pokedex_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/pokedex_appbar.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/pokedex_gen_filter.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/pokedex_header.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/pokedex_pokemon_card.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/pokedex_search_bar.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  late ScrollController scrollController;
  PokemonGenerationEnum selectedGeneration = PokemonGenerationEnum.gen1;
  bool showScrollButton = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollWatcher);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollWatcher);
    super.dispose();
  }

  void _scrollWatcher() {
    if (scrollController.offset > 100.0) {
      context.read<PokedexScrollBloc>().add(PokedexScrollEventEnable());
    } else {
      context.read<PokedexScrollBloc>().add(PokedexScrollEventDisable());
    }
  }

  void _scrollTop() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 250), curve: Curves.easeInCubic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PokedexAppbar(),
      floatingActionButton: BlocSelector<PokedexScrollBloc, PokedexScrollState, bool>(
        selector: (state) {
          if (state is PokedexScrollData) {
            return state.isActive;
          }
          return false;
        },
        builder: (context, isActive) => Visibility(
          visible: isActive,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: _scrollTop,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100.0))),
            child: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const ScrollPhysics(), //* Precisa disso aqui pra definir como scroll padrão
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const PokedexHeader(),
            const PokedexSearchBar(),
            //
            //* Listener que atualiza o filtro selecionado
            //
            BlocSelector<PokedexBloc, PokedexState, PokemonGenerationEnum>(
              selector: (state) {
                context.read<PokedexBloc>().add(PokedexEventLoad());
                if (state is PokedexStateFetchPokemon) {
                  selectedGeneration = state.generation;
                } else if (state is PokedexStateLoading) {
                  selectedGeneration = state.generation;
                }
                return selectedGeneration;
              },
              builder: (context, generation) {
                return PokedexGenFilter(selectedGeneration: generation);
              },
            ),
            //
            //* Builder da grid da pokedéx que é triggerado quando ocorre
            //* uma alteração na lista de pokemons
            //
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
                    top: 20,
                    bottom: 90,
                    left: 20,
                    right: 20,
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridCrossAxisCount,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 16,
                    ),
                    physics: const NeverScrollableScrollPhysics(), //* Desligando o scroll da ListView
                    shrinkWrap: true, //* ListView com o tamanho necessário
                    itemCount: pokemonModelList.length,
                    itemBuilder: (context, index) {
                      // debugPrint('${context.read<PokedexBloc>().state.runtimeType}');
                      return PokedexPokemonCard(model: pokemonModelList[index]);
                    },
                  ),
                );
              },
            ),
            //
            //* Loader que reage a partir do status de loading armazenado nos states da página
            //
            BlocSelector<PokedexBloc, PokedexState, bool>(
              selector: (state) {
                bool isLoading = false;

                if (state is PokedexStateLoading) {
                  isLoading = state.isLoading;
                } else if (state is PokedexStateFetchPokemon) {
                  isLoading = state.isLoading;
                }

                if (isLoading) {
                  context.read<PokedexBloc>().add(PokedexEventLoad());
                  return isLoading;
                }
                return false;
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
