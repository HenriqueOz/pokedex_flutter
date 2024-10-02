import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_scroll_bloc/pokedex_scroll_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_list_bloc/pokedex_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/header/pokedex_appbar.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/drawer/pokedex_drawer.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/list/pokedex_error_button.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/list/pokedex_filter_update.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/list/pokedex_floating_button.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/header/pokedex_header.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/list/pokedex_grid.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/list/pokedex_loader.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/header/search/pokedex_search_bar.dart';
import 'package:pokedex_app/app/repositories/profile_repository.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _loadDefaultData();
    scrollController = ScrollController()..addListener(_scrollWatcher);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollWatcher);
    super.dispose();
  }

  void _loadDefaultData() async {
    await context.read<ProfileRepository>().fillDefaultData();
  }

  void _scrollWatcher() {
    if (scrollController.offset > 300.0) {
      context.read<PokedexScrollBloc>().add(PokedexScrollEventEnable());
    } else {
      context.read<PokedexScrollBloc>().add(PokedexScrollEventDisable());
    }

    final state = context.read<PokedexBloc>().state;
    final bool hasError;
    final bool canLoad;

    hasError = (state is PokedexStateError);

    if (state is PokedexStateFetchPokemon) {
      canLoad = state.canLoad;
    } else if (state is PokedexStateLoading) {
      canLoad = state.canLoad;
    } else {
      canLoad = false;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent * .9) {
      if (canLoad && !hasError) {
        context.read<PokedexBloc>().add(PokedexEventLoad());
      }
    }
  }

  void _scrollTop() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 250), curve: Curves.easeInCubic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PokedexAppbar(),
      drawer: const PokedexDrawer(),
      floatingActionButton: PokedexFloatingButton(onClick: _scrollTop),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const ScrollPhysics(), //* Precisa disso aqui pra definir como scroll padrão
        child: const Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                PokedexHeader(),
                PokedexSearchBar(),
                Divider(
                  height: 40,
                  endIndent: 80,
                  indent: 80,
                  thickness: .5,
                ),
                PokedexFilterUpdate(),
                PokedexGrid(),
                PokedexLoader(),
                PokedexErrorButton(),
                SizedBox(height: 60),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
