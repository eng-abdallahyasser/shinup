import 'package:shinup/features/counter/domain/entities/counter_entity.dart';
import 'package:shinup/features/counter/domain/repositories/counter_repository.dart';

class GetCounterUseCase {
  final CounterRepository _repository;

  GetCounterUseCase(this._repository);

  CounterEntity call() {
    return _repository.getCounter();
  }
}
