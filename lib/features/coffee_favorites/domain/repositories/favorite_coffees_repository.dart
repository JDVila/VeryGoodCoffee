import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/local/app_database.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/favorite_coffee_model.dart';

abstract class FavoriteCoffeesRepository {
  const FavoriteCoffeesRepository({required this.database});

  final AppDatabase database;

  Future<DataState<List<FavoriteCoffeeModel>>> getFavoriteCoffees();
}
