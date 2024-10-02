import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokedex_app/app/modules/type_combination/cubit/type_combination_cubit.dart';
import 'package:pokedex_app/app/modules/type_combination/type_combination_page.dart';
import 'package:provider/provider.dart';

class TypeCombinationModule {
  static Route pageBuilder({required RouteSettings? settings}) {
    return PageTransition(
      settings: settings,
      type: PageTransitionType.rightToLeft,
      child: MultiBlocProvider(
        providers: [
          Provider(
            lazy: false,
            create: (BuildContext context) => TypeCombinationCubit()..reloadList(),
          ),
        ],
        child: const TypeCombinationPage(),
      ),
    );
  }
}
