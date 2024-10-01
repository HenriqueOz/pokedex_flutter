import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/modules/favorites/bloc/favorites_bloc.dart';

class FavoritesLoader extends StatelessWidget {
  const FavoritesLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoritesBloc, FavoritesStates, bool>(
      selector: (state) {
        if (state is FavoritesLoading) {
          return true;
        } else if (state is FavoritesError) {
          return false;
        }
        return false;
      },
      builder: (context, loading) {
        return Visibility(
          visible: loading,
          child: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
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
