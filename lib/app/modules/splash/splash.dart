import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/splash/bloc/splash_bloc.dart';
import 'package:pokedex_app/app/repositories/pokemon_name_list_repository.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<void> _loadNameList() async {
    await context.read<PokemonNameListRepository>().loadNameList();
    Navigator.pushNamed(context, '/pokedex/');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* listener de success
            BlocListener<SplashBloc, SplashState>(
              listenWhen: (previous, current) => (current is SplashSuccess),
              listener: (context, states) {
                Navigator.pushNamed(context, '/pokedex/');
              },
              child: const SizedBox.shrink(),
            ),

            //* icone de loading
            BlocSelector<SplashBloc, SplashState, bool>(
              selector: (state) {
                return state is SplashLoading;
              },
              builder: (context, loading) {
                return Visibility(
                  visible: loading,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      Text('Loading content...', style: CustomTheme.pokedexLabels),
                    ],
                  ),
                );
              },
            ),
            //* mensagem de erro
            BlocSelector<SplashBloc, SplashState, String>(
              selector: (state) {
                if (state is SplashError) {
                  return state.message;
                }
                return '';
              },
              builder: (context, error) {
                return Visibility(
                  visible: error.isNotEmpty,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(error, style: CustomTheme.pokedexLabels),
                      ElevatedButton(
                        onPressed: () {
                          context.read<SplashBloc>().add(SplashLoad());
                        },
                        style: CustomTheme.primaryButton.copyWith(
                          backgroundColor: const WidgetStatePropertyAll(Colors.white),
                        ),
                        child: Text('Try again', style: CustomTheme.pokedexLabels.copyWith(color: Colors.black)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
