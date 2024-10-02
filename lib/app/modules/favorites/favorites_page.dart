import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/favorites/bloc/favorites_bloc.dart';
import 'package:pokedex_app/app/modules/favorites/widgets/favorites_app_bar.dart';
import 'package:pokedex_app/app/modules/favorites/widgets/favorites_error_button.dart';
import 'package:pokedex_app/app/modules/favorites/widgets/favorites_grid.dart';
import 'package:pokedex_app/app/modules/favorites/widgets/favorites_loader.dart';
import 'package:pokedex_app/app/modules/favorites/widgets/favorities_header.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() async {
    final state = context.read<FavoritesBloc>().state;

    if (state is! FavoritesError) {
      if (_scrollController.offset > _scrollController.position.maxScrollExtent * .9) {
        context.read<FavoritesBloc>().add(FavoritesLoad());
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FavoritesBloc>().add(FavoritesRefresh());
      },
      color: CustomTheme.primaryColor,
      backgroundColor: Colors.white,
      child: Scaffold(
        appBar: const FavoritesAppBar(),
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FavoritesHeader(),
                Divider(
                  height: 40,
                  endIndent: 80,
                  indent: 80,
                  thickness: .5,
                ),
                FavoritesGrid(),
                FavoritesLoader(),
                FavoritesErrorButton(),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
