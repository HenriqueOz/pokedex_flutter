import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_generation_enum.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_scroll_bloc/pokedex_scroll_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_list_bloc/pokedex_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/header/pokedex_appbar.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/list/pokedex_gen_filter.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/header/pokedex_header.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/list/pokedex_pokemon_card.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/header/search/pokedex_search_bar.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  late ScrollController scrollController;
  PokemonGenerationBounds selectedGeneration = PokemonGenerationBounds.gen1;
  bool canLoad = false;
  bool hasError = false;

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
    //* se meu scroll for maior que 300px eu amndo um evento de habilitação de botão de scroll
    //* caso contrário, mando um evento para desabilitar
    if (scrollController.offset > 300.0) {
      context.read<PokedexScrollBloc>().add(PokedexScrollEventEnable());
    } else {
      context.read<PokedexScrollBloc>().add(PokedexScrollEventDisable());
    }

    //* quando meu scroll atingir 95% da altura da página eu disparo um evento de load do feed
    if (scrollController.offset >= scrollController.position.maxScrollExtent * .95) {
      if (canLoad && !hasError) {
        context.read<PokedexBloc>().add(PokedexEventLoad());
      }
    }
  }

  //* função para voltar o scroll da página para o topo
  void _scrollTop() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 250), curve: Curves.easeInCubic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PokedexAppbar(),
      //* Mostrando o botão só quando o state do bloc retornar que ele está ativo
      floatingActionButton: BlocSelector<PokedexScrollBloc, PokedexScrollState, bool>(
        selector: (state) {
          if (state is PokedexScrollData) {
            return state.isActive;
          }
          return false;
        },
        builder: (context, isActive) {
          return TweenAnimationBuilder(
            //* animação de crescimento
            tween: Tween<double>(
              begin: isActive ? 0 : 1,
              end: isActive ? 1 : 0,
            ),
            duration: const Duration(milliseconds: 150),
            //* Botão
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: FloatingActionButton(
                  backgroundColor: CustomTheme.primaryColor,
                  onPressed: _scrollTop,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100.0))),
                  child: const Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              );
            },
          );
        },
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const ScrollPhysics(), //* Precisa disso aqui pra definir como scroll padrão
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const PokedexHeader(),
                const PokedexSearchBar(),
                const Divider(
                  height: 40,
                  endIndent: 80,
                  indent: 80,
                  thickness: .5,
                ),
                //
                //* Listener que atualiza o filtro selecionado
                //
                BlocSelector<PokedexBloc, PokedexState, PokemonGenerationBounds>(
                  selector: (state) {
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
                    } else if (state is PokedexStateFetchPokemon) {
                      return state.pokemonModelList;
                    } else if (state is PokedexStateError) {
                      return state.pokemonModelListHolder;
                    }

                    return <PokemonModel>[];
                  },
                  builder: (context, pokemonModelList) {
                    final orientation = MediaQuery.of(context).orientation;
                    final gridCrossAxisCount = orientation == Orientation.portrait ? 2 : 3;

                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
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
                    if (state is PokedexStateLoading) {
                      canLoad = state.canLoad;
                    } else if (state is PokedexStateFetchPokemon) {
                      canLoad = state.canLoad;
                    } else if (state is PokedexStateError) {
                      canLoad = false;
                    }
                    return canLoad;
                  },
                  builder: (context, canLoad) {
                    return Align(
                      alignment: Alignment.center,
                      child: Visibility(
                        visible: canLoad,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                //
                //* Botão para refresh quando ocorre algum erro no fetch
                //
                BlocSelector<PokedexBloc, PokedexState, String>(
                  selector: (state) {
                    if (state is PokedexStateError) {
                      hasError = true;
                      return state.error;
                    }
                    hasError = false;
                    return "";
                  },
                  builder: (context, message) {
                    return Align(
                      alignment: Alignment.center,
                      child: Visibility(
                        visible: message.isNotEmpty,
                        child: Column(
                          children: [
                            Text(
                              message,
                              style: CustomTheme.body,
                            ),
                            ElevatedButton(
                              style: CustomTheme.primaryButton,
                              onPressed: () {
                                context.read<PokedexBloc>().add(PokedexEventLoad());
                              },
                              child: const Text('Try again'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 60),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
