import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/core/resources/database_dao_wrapper.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/favorite_coffee_model.dart';

abstract class FavoriteCoffeesRepository {
  const FavoriteCoffeesRepository({required this.databaseDaoWrapper});

  final DatabaseDaoWrapper databaseDaoWrapper;

  Future<DataState<List<FavoriteCoffeeModel>>> getFavoriteCoffees();
}
