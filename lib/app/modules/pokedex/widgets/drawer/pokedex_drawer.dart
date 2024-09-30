import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/drawer/pokedex_drawer_header.dart';

class PokedexDrawer extends StatelessWidget {
  const PokedexDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(),
        width: MediaQuery.of(context).size.width * .8,
        child: Column(
          children: [
            //* Header do drawer
            const PokedexDrawerHeader(),
            //* opções do drawer
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.grey.shade700,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
