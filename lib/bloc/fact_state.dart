part of 'fact_bloc.dart';

enum ScreenStatus { loading, success, error, unknown }

class FactState {
  final ScreenStatus status;
  final String? info;

  const FactState({
    required this.status,
    this.info,
  });
}
