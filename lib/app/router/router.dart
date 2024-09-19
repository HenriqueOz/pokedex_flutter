import 'package:flutter/material.dart';
import 'package:pokedex_app/app/modules/pokedex/pokedex_module.dart';
import 'package:pokedex_app/app/modules/splash/splash.dart';

class Routers {
  final routers = <String, WidgetBuilder>{
    '/': (BuildContext context) => const Splash(),
    ...PokedexModule.routers,
  };
}
