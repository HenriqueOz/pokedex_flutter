import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class TabStats extends StatelessWidget {
  final List<String> keys = ["hp", "attack", "defense", "special-attack", "special-defense", "speed"];
  final List<String> labels = ["HP", "ATK", "DEF", "SP ATK", "SP DEF", "SPD"];
  final Color primaryColor;
  final Color secondaryColor;
  final Map<String, int> stats;

  TabStats({super.key, required this.stats, required this.primaryColor, required this.secondaryColor});

  int getStatsTotal() {
    int total = 0;
    for (var item in stats.entries) {
      total += item.value;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Base Stats',
                style: CustomTheme.pokedexLabels.copyWith(color: primaryColor),
              ),
              Text(
                'Values',
                style: CustomTheme.pokedexLabels.copyWith(color: primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 25),
          for (int i = 0; i < labels.length; i++)
            _statsLine(
              label: labels[i],
              stats: stats[keys[i]],
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
            ),
          Divider(
            height: 20,
            indent: MediaQuery.of(context).size.width * .4,
            endIndent: MediaQuery.of(context).size.width * .4,
            color: primaryColor,
          ),
          _statsLine(
            label: 'TOTAL',
            stats: getStatsTotal(),
            showProgress: false,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
          ),
        ],
      ),
    );
  }
}

Widget _statsLine({
  required String label,
  required dynamic stats,
  required Color primaryColor,
  required Color secondaryColor,
  bool showProgress = true,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        height: 20,
        width: 45,
        child: Text(
          label,
          textAlign: TextAlign.start,
          style: CustomTheme.pokedexLabels.copyWith(color: primaryColor, fontSize: 14),
        ),
      ),
      const SizedBox(width: 5),
      Visibility(
        visible: showProgress,
        child: Expanded(
          child: LinearProgressIndicator(
            color: primaryColor,
            backgroundColor: Colors.grey.withOpacity(.25),
            value: stats / 200,
            minHeight: 10,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      const SizedBox(width: 5),
      SizedBox(
        width: 35,
        child: Text(
          '$stats',
          textAlign: TextAlign.right,
          style: CustomTheme.body.copyWith(color: Colors.grey.shade500),
        ),
      ),
    ],
  );
}
