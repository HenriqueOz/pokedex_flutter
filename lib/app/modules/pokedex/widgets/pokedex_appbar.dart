import 'package:flutter/material.dart';

class PokedexAppbar extends StatelessWidget implements PreferredSizeWidget {
  const PokedexAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextButton(
            onPressed: () {},
            child: const Text('Filtrar'),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
