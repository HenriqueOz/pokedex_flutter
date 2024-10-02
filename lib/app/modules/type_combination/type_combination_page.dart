import 'package:flutter/material.dart';
import 'package:pokedex_app/app/modules/type_combination/widgets/type_combination_app_bar.dart';
import 'package:pokedex_app/app/modules/type_combination/widgets/type_combination_buttons.dart';
import 'package:pokedex_app/app/modules/type_combination/widgets/type_combination_header.dart';
import 'package:pokedex_app/app/modules/type_combination/widgets/type_combination_selection_box.dart';

class TypeCombinationPage extends StatelessWidget {
  const TypeCombinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TypeCombinationAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const TypeCombinationHeader(),
              _divider(),
              const TypeCombinationSelectionBox(),
              const SizedBox(height: 25),
              const TypeCombinationGenerateButton(),
              _divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      height: 40,
      endIndent: 80,
      indent: 80,
      thickness: .5,
    );
  }
}
