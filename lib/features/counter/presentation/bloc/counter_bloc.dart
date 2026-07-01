import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shineup/features/counter/domain/usecases/get_counter_usecase.dart';
import 'package:shineup/features/counter/domain/usecases/increment_counter_usecase.dart';

// ── Events ──────────────────────────────────────────────────────────────────

sealed class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object?> get props => [];
}

final class CounterStarted extends CounterEvent {
  const CounterStarted();
}

final class CounterIncrementPressed extends CounterEvent {
  const CounterIncrementPressed();
}

// ── States ──────────────────────────────────────────────────────────────────

sealed class CounterState extends Equatable {
  final int count;
  const CounterState(this.count);

  @override
  List<Object?> get props => [count];
}

final class CounterInitial extends CounterState {
  const CounterInitial() : super(0);
}

final class CounterValue extends CounterState {
  const CounterValue(super.count);
}

// ── Bloc ────────────────────────────────────────────────────────────────────

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final GetCounterUseCase _getCounterUseCase;
  final IncrementCounterUseCase _incrementCounterUseCase;

  CounterBloc(
    this._getCounterUseCase,
    this._incrementCounterUseCase,
  ) : super(const CounterInitial()) {
    on<CounterStarted>(_onStarted);
    on<CounterIncrementPressed>(_onIncrementPressed);
  }

  void _onStarted(CounterStarted event, Emitter<CounterState> emit) {
    final counter = _getCounterUseCase.call();
    emit(CounterValue(counter.value));
  }

  Future<void> _onIncrementPressed(
    CounterIncrementPressed event,
    Emitter<CounterState> emit,
  ) async {
    final updated = await _incrementCounterUseCase.call();
    emit(CounterValue(updated.value));
  }
}
