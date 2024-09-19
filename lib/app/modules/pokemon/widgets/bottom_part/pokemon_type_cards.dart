import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/formatter/formatter.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class PokemonTypesIcons extends StatelessWidget {
  final Color primaryColor;
  final String typePrimary;
  final Color? secondaryColor;
  final String? typeSecondary;

  const PokemonTypesIcons({super.key, required this.primaryColor, required this.typePrimary, this.secondaryColor, this.typeSecondary});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TypeCard(color: primaryColor, label: typePrimary),
        SizedBox(width: typeSecondary != null ? 20 : 0),
        _TypeCard(color: secondaryColor, label: typeSecondary),
      ],
    );
  }
}

Widget _TypeCard({required Color? color, required String? label}) {
  return label != null
      ? Opacity(
          opacity: .85,
          child: Container(
            height: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: color,
            ),
            child: Text(
              Formatter.captalize(text: label),
              style: CustomTheme.body.copyWith(color: Colors.white),
            ),
          ),
        )
      : const SizedBox.shrink();
}
