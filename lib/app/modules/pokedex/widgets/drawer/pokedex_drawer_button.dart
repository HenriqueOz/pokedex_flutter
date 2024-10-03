import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class PokedexDrawerButton extends StatelessWidget {
  final String routeName;
  final String label;
  final IconData iconData;
  final Object? arguments;

  const PokedexDrawerButton({super.key, required this.routeName, required this.label, required this.iconData, this.arguments});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 3,
            ),
          ],
        ),
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          child: ListTile(
            onTap: () async {
              Scaffold.of(context).closeDrawer();
              Navigator.pushNamed(context, routeName, arguments: arguments);
            },
            splashColor: Colors.grey.shade300,
            leading: Icon(
              iconData,
              color: CustomTheme.primaryColor,
            ),
            title: Text(label),
          ),
        ),
      ),
    );
  }
}
