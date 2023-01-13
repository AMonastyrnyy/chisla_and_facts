import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';

//Блок для смены темы
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: true)) {
    on<ThemeChanged>(_onThemeChanged);
  }

  _onThemeChanged(event, emit) {
    if (state.themeData) {
      emit(state.copyWith(themeData: false));
    } else {
      emit(state.copyWith(themeData: true));
    }
  }
}

//Состояние
class ThemeState {
  final bool themeData;

  ThemeState({required this.themeData});

  ThemeState copyWith({bool? themeData}) {
    return ThemeState(themeData: themeData ?? this.themeData);
  }
}

//Эвент
@immutable
abstract class ThemeEvent {}

class ThemeChanged extends ThemeEvent {}
