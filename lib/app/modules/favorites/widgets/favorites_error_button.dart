import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/favorites/bloc/favorites_bloc.dart';

class FavoritesErrorButton extends StatelessWidget {
  const FavoritesErrorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: BlocSelector<FavoritesBloc, FavoritesStates, String>(
        selector: (state) {
          if (state is FavoritesError) {
            return state.message;
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
                      context.read<FavoritesBloc>().add(FavoritesLoad());
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
