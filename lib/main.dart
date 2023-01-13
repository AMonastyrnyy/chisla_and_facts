import 'package:chisla_and_facts/bloc/fact_bloc.dart';
import 'package:chisla_and_facts/repository/repository.dart';
import 'package:chisla_and_facts/ui/main_screen.dart';
import 'package:chisla_and_facts/ui/theme/app_theme.dart';
import 'package:chisla_and_facts/ui/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => FactBloc(Repository()),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.themeData ? myThemeLight : myThemeDark,
            home: const MainScreen(),
          );
        },
      ),
    ),
  );
}