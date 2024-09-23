import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/initializer/initializer.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Initializer().isNameListLoaded();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Navigator.pushNamed(context, '/pokedex/');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
