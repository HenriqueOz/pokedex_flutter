import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class TabStats extends StatelessWidget {
  final List<String> keys = ["hp", "attack", "defense", "special-attack", "special-defense", "speed"];
  final List<String> labels = ["HP", "ATK", "DEF", "SP ATK", "SP DEF", "SPD"];
  final Color primaryColor;
  final Color secondaryColor;
  final Map<String, dynamic> stats;

  TabStats({super.key, required this.stats, required this.primaryColor, required this.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Base Stats',
                    style: CustomTheme.pokedexLabels.copyWith(color: primaryColor, fontSize: 14),
                  ),
                  Text(
                    'Values',
                    style: CustomTheme.pokedexLabels.copyWith(color: primaryColor, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            for (int i = 0; i < labels.length; i++)
              _statsLine(
                label: labels[i],
                stats: stats[keys[i]],
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
              )
          ],
        ),
      ),
    );
  }
}

Widget _statsLine({
  required String label,
  required dynamic stats,
  required Color primaryColor,
  required Color secondaryColor,
}) {
  return Row(
    children: [
      SizedBox(
        height: 20,
        width: 35,
        child: Text(
          label,
          textAlign: TextAlign.start,
          style: CustomTheme.pokedexLabels.copyWith(color: primaryColor, fontSize: 14),
        ),
      ),
      const SizedBox(width: 20),
      Expanded(
        child: LinearProgressIndicator(
          color: primaryColor,
          backgroundColor: Colors.grey.withOpacity(.25),
          value: stats / 200,
          minHeight: 10,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
      ),
      const SizedBox(width: 20),
      SizedBox(
        child: Text(
          '$stats',
          style: CustomTheme.body.copyWith(color: Colors.grey.shade500),
        ),
      ),
    ],
  );
}
