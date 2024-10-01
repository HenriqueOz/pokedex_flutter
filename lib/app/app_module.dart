import 'package:flutter/material.dart';
import 'package:pokedex_app/app/app_widget.dart';
import 'package:pokedex_app/app/core/database/sqlite_database.dart';
import 'package:provider/provider.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SqliteDatabase>(
          lazy: false,
          create: (context) => SqliteDatabase.createInstance(), //..deleteDb(),
        ),
      ],
      child: const AppWidget(),
    );
  }
}
