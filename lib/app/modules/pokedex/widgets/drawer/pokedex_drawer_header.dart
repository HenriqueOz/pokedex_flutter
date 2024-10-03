import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/formatter/formatter.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/models/user_model.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_user_cubit/pokedex_user_cubit.dart';

class PokedexDrawerHeader extends StatelessWidget {
  const PokedexDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
          HSLColor.fromColor(CustomTheme.primaryColor).withLightness(.65).toColor(),
          CustomTheme.primaryColor,
        ], stops: const [
          0.25,
          0.25
        ]),
      ),
      height: MediaQuery.of(context).size.height * .2,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          //* opções do header
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //* fechar drawer
              IconButton(
                onPressed: () {
                  Scaffold.of(context).closeDrawer();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          //* imagem do user
          BlocSelector<PokedexUserCubit, PokedexUserStates, UserModel>(
            selector: (state) {
              if (state is PokedexUserFetch) {
                return state.userModel;
              }
              return UserModel.empty();
            },
            builder: (context, model) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: () {
                        final blobString = model.blobImage ?? '';
                        Uint8List bytes;

                        if (model.blobImage != null) {
                          bytes = base64Decode(blobString);

                          return Image.memory(bytes).image;
                        }
                      }(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Formatter.captalize(text: model.name),
                            style: CustomTheme.pokedexLabels.copyWith(
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            Formatter.captalize(text: model.region),
                            style: CustomTheme.pokedexLabels,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
