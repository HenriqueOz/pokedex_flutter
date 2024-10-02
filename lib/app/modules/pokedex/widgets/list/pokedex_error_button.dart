import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_list_bloc/pokedex_bloc.dart';

class PokedexErrorButton extends StatelessWidget {
  const PokedexErrorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PokedexBloc, PokedexState, String>(
      selector: (state) {
        if (state is PokedexStateError) {
          return state.error;
        }
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
    );
  }
}
