import 'package:flutter/material.dart';

class PokemonBackgroud extends StatelessWidget {
  const PokemonBackgroud({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Opacity(
        opacity: .05,
        child: Container(
          height: 600,
          width: 600,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            shape: BoxShape.circle,
            border: Border.all(
              width: 10,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
