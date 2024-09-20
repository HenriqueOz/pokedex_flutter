import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class TabDescription extends StatelessWidget {
  final Map<String, dynamic> description;
  final List<String> keys = ['height', 'weight', 'base_happiness', 'capture_rate', 'pokedex_entry'];
  final Color primaryColor;
  final Color secondaryColor;

  TabDescription({super.key, required this.description, required this.primaryColor, required this.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(
            'Entry',
            style: CustomTheme.pokedexLabels.copyWith(
              color: primaryColor,
            ),
          ),
          Text(description[keys[4]]),
        ],
      ),
    );
  }
}
