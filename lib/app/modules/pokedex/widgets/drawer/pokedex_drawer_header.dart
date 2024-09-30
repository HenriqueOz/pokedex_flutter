import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
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
      color: CustomTheme.primaryColor,
      height: MediaQuery.of(context).size.height * .25,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          //* opções do header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          BlocSelector<PokedexUserCubit, PokedexUserStates, UserModel?>(
            selector: (state) {
              if (state is PokedexUserFetch) {
                return state.userModel;
              }
              return null;
            },
            builder: (context, model) {
              if (model != null) {
                final String blobImage = model.blobImage ?? '';
                Uint8List? bytes;

                if (blobImage.isNotEmpty) {
                  bytes = const Base64Decoder().convert(blobImage);
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: () {
                        if (model.blobImage == null) {
                          return const CachedNetworkImageProvider('https://i1.sndcdn.com/artworks-000193803962-tla7ov-t500x500.jpg');
                        } else {
                          return Image.memory(bytes!).image;
                        }
                      }(),
                    ),
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
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
