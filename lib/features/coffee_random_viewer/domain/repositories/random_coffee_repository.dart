import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/random_coffee_model.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/remote/random_coffee_service.dart';

abstract class RandomCoffeeRepository {
  const RandomCoffeeRepository({required this.service});

  final RandomCoffeeService service;
  Future<DataState<RandomCoffeeModel>> getRandomCoffee();
}
