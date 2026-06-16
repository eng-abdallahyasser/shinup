import 'package:shinup/features/counter/domain/entities/counter_entity.dart';

class CounterModel extends CounterEntity {
  const CounterModel({super.value});

  factory CounterModel.fromJson(Map<String, dynamic> json) {
    return CounterModel(value: json['value'] as int? ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }

  factory CounterModel.fromEntity(CounterEntity entity) {
    return CounterModel(value: entity.value);
  }
}
