import 'package:flutter/material.dart';

class PokedexAppbar extends StatelessWidget implements PreferredSizeWidget {
  const PokedexAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      //* botão principal
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.sort)),
      ),
      //* botões appbar
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 10),
      //     child: TextButton(
      //       onPressed: () async {
      //         await context.read<ProfileRepository>().getUser();
      //       },
      //       child: const Text(
      //         'Filter',
      //         style: CustomTheme.body,
      //       ),
      //     ),
      //   ),
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
