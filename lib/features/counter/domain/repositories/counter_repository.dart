import 'package:shineup/features/counter/domain/entities/counter_entity.dart';

abstract class CounterRepository {
  CounterEntity getCounter();
  Future<void> saveCounter(CounterEntity counter);
}
