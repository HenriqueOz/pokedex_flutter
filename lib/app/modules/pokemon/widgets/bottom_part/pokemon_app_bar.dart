import 'package:flutter/material.dart';

class PokemonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PokemonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      actions: [
        IconButton(
          onPressed: () {
            //! Adicionar ou remover favorito
          },
          icon: const Icon(
            Icons.favorite_border,
            size: 25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/pokedex/'));
            },
            icon: const Icon(
              Icons.home,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
