import 'package:sqflite/sqflite.dart';
import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_favorites/domain/repositories/favorite_coffees_repository.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/favorite_coffee_model.dart';

class FavoriteCoffeesRepositoryImpl extends FavoriteCoffeesRepository {
  FavoriteCoffeesRepositoryImpl({required super.databaseDaoWrapper});

  @override
  Future<DataState<List<FavoriteCoffeeModel>>> getFavoriteCoffees() async {
    try {
      final result = await databaseDaoWrapper.getAllFavoriteCoffees();
      if (result.isEmpty) {
        return const DataSuccess<List<FavoriteCoffeeModel>>(data: []);
      } else {
        return DataSuccess<List<FavoriteCoffeeModel>>(data: result);
      }
    } on DatabaseException catch (e) {
      return DataFailure<List<FavoriteCoffeeModel>>(
        errorMessage: e.getResultCode().toString(),
      );
    }
  }
}
