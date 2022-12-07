part of 'fact_bloc.dart';

abstract class FactEvent {}

class GetInfoEvent extends FactEvent{
  final String number;
  GetInfoEvent(this.number);
}
