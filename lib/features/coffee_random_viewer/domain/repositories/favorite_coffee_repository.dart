import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/local/app_database.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/favorite_coffee_model.dart';

abstract class FavoriteCoffeeRepository {
  const FavoriteCoffeeRepository({required this.database});

  final AppDatabase database;
  Future<DataState<void>> addFavoriteCoffee(
    FavoriteCoffeeModel newFavorite,
  );

  Future<DataState<void>> removeFavoriteCoffee(
    FavoriteCoffeeModel formerFavorite,
  );

  Future<DataState<List<FavoriteCoffeeModel>>> checkFavoriteCoffee(
    FavoriteCoffeeModel checkCoffeeModel,
  );
}
