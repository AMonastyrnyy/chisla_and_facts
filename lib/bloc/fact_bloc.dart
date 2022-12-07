import 'package:chisla_and_facts/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fact_event.dart';

part 'fact_state.dart';

class FactBloc extends Bloc<FactEvent, FactState> {
  FactBloc(this._repository) : super(const FactState(status: ScreenStatus.loading)) {
    on<GetInfoEvent>(_getInfo);
  }

  final Repository _repository;

  Future<void> _getInfo(GetInfoEvent event, Emitter<FactState> emit) async {
    emit(const FactState(status: ScreenStatus.loading));
    try {
      if (event.number == '') {
        final String data = await _repository.getInfo(event.number);
        emit(FactState(status: ScreenStatus.unknown, info: data));
      } else {
        final String data = await _repository.getInfo(event.number);
        emit(FactState(status: ScreenStatus.success, info: data));
      }
    } catch (_) {
      emit(const FactState(status: ScreenStatus.error));
    }
  }
}
