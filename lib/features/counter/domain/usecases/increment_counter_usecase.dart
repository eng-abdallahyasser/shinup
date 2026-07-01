import 'package:shineup/features/counter/domain/entities/counter_entity.dart';
import 'package:shineup/features/counter/domain/repositories/counter_repository.dart';

class IncrementCounterUseCase {
  final CounterRepository _repository;

  IncrementCounterUseCase(this._repository);

  Future<CounterEntity> call() async {
    final current = _repository.getCounter();
    final updated = current.copyWith(value: current.value + 1);
    await _repository.saveCounter(updated);
    return updated;
  }
}
