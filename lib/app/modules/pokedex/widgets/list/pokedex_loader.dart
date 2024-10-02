import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_list_bloc/pokedex_bloc.dart';

class PokedexLoader extends StatelessWidget {
  const PokedexLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PokedexBloc, PokedexState, bool>(
      selector: (state) {
        if (state is PokedexStateLoading) {
          return state.canLoad;
        } else if (state is PokedexStateFetchPokemon) {
          return state.canLoad;
        }
        return false;
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
    );
  }
}
