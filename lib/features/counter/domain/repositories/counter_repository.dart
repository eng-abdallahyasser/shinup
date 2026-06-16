import 'package:shinup/features/counter/domain/entities/counter_entity.dart';

abstract class CounterRepository {
  CounterEntity getCounter();
  Future<void> saveCounter(CounterEntity counter);
}
