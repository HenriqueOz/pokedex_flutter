import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_scroll_bloc/pokedex_scroll_bloc.dart';

class PokedexFloatingButton extends StatelessWidget {
  final void Function() onClick;

  const PokedexFloatingButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PokedexScrollBloc, PokedexScrollState, bool>(
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
                onPressed: onClick,
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
    );
  }
}
