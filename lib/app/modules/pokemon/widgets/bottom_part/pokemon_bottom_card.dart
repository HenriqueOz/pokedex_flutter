import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/pokemon_info_model.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokemon/bloc/pokemon_info_bloc/pokemon_info_bloc.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/bottom_part/pokemon_info_tab_bar.dart';
import 'package:pokedex_app/app/modules/pokemon/widgets/bottom_part/pokemon_type_cards.dart';

class PokemonBottomCard extends StatelessWidget {
  final PokemonModel model;

  const PokemonBottomCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat('000');
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.grey.shade700,
              spreadRadius: 1,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
            top: 20,
          ),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    () {
                      if (model.id < 10000) {
                        return '#${f.format(model.id)}';
                      }
                      return 'Form';
                    }(),
                    style: CustomTheme.title.copyWith(color: model.primaryColor, fontSize: 30),
                  ),
                  //* Tipos
                  PokemonTypesIcons(
                    primaryColor: model.primaryColor!,
                    typePrimary: model.typePrimary,
                    secondaryColor: model.secondaryColor,
                    typeSecondary: model.typeSecondary,
                  ),
                ],
              ),
              Divider(
                color: model.primaryColor,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                height: 40,
              ),
              //* Erro
              BlocSelector<PokemonInfoBloc, PokemonInfoState, String>(
                selector: (state) {
                  if (state is PokemonInfoError) {
                    return state.message;
                  }
                  return '';
                },
                builder: (context, message) {
                  return Visibility(
                    visible: message.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Column(
                        children: [
                          Text(
                            message,
                            style: CustomTheme.body,
                          ),
                          ElevatedButton(
                            style: CustomTheme.primaryButton.copyWith(backgroundColor: WidgetStatePropertyAll(model.primaryColor!)),
                            onPressed: () {
                              context.read<PokemonInfoBloc>().add(PokemonInfoLoad(id: model.id));
                            },
                            child: const Text('Try again'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              //* Loading
              BlocSelector<PokemonInfoBloc, PokemonInfoState, bool>(
                selector: (state) {
                  return (state is PokemonInfoLoading);
                },
                builder: (context, loading) {
                  return Visibility(
                    visible: loading,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: model.primaryColor!,
                        ),
                      ),
                    ),
                  );
                },
              ),
              //* Sucesso
              BlocSelector<PokemonInfoBloc, PokemonInfoState, PokemonInfoModel>(
                selector: (state) {
                  if (state is PokemonInfoFetch) {
                    return state.data;
                  }
                  return PokemonInfoModel.empty();
                },
                builder: (context, data) {
                  return Visibility(
                    visible: data.description.isNotEmpty,
                    child: PokemonInfoTabBar(mainModel: model, primaryColor: model.primaryColor!, secondaryColor: model.secondaryColor, data: data),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
