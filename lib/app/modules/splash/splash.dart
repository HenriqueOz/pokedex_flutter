import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/splash/bloc/splash_bloc.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.primaryColor,
      body: Center(
        child: BlocListener<SplashBloc, SplashState>(
          listenWhen: (previous, current) => (current is SplashSuccess),
          listener: (context, states) {
            Navigator.pushNamed(context, '/pokedex/');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
      ),
    );
  }
}
