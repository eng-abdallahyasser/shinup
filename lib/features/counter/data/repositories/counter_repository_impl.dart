import 'package:shinup/features/counter/data/datasources/counter_local_datasource.dart';
import 'package:shinup/features/counter/data/models/counter_model.dart';
import 'package:shinup/features/counter/domain/entities/counter_entity.dart';
import 'package:shinup/features/counter/domain/repositories/counter_repository.dart';

class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDataSource _dataSource;

  CounterRepositoryImpl(this._dataSource);

  @override
  CounterEntity getCounter() {
    final value = _dataSource.readCounter();
    return CounterModel(value: value);
  }

  @override
  Future<void> saveCounter(CounterEntity counter) async {
    final model = CounterModel.fromEntity(counter);
    await _dataSource.writeCounter(model.value);
  }
}
