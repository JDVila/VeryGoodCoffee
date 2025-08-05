import 'package:sqflite/sqflite.dart';
import 'package:verygoodcoffee/core/resources/data_state.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/models/favorite_coffee_model.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/domain/repositories/favorite_coffee_repository.dart';

class FavoriteCoffeeRepositoryImpl extends FavoriteCoffeeRepository {
  FavoriteCoffeeRepositoryImpl({required super.databaseDaoWrapper});

  @override
  Future<DataState<void>> addFavoriteCoffee(
    FavoriteCoffeeModel newFavorite,
  ) async {
    try {
      await databaseDaoWrapper.insertFavoriteCoffee(newFavorite);
      return const DataSuccess<void>(data: null);
    } on DatabaseException catch (e) {
      return DataFailure<void>(errorMessage: e.getResultCode().toString());
    }
  }

  @override
  Future<DataState<void>> removeFavoriteCoffee(
    FavoriteCoffeeModel formerFavorite,
  ) async {
    try {
      await databaseDaoWrapper.deleteFavoriteCoffee(formerFavorite);
      return const DataSuccess<void>(data: null);
    } on DatabaseException catch (e) {
      return DataFailure<void>(errorMessage: e.getResultCode().toString());
    }
  }

  @override
  Future<DataState<List<FavoriteCoffeeModel>>> checkFavoriteCoffee(
    FavoriteCoffeeModel checkCoffeeModel,
  ) async {
    try {
      final result =
          await databaseDaoWrapper.checkFavoriteCoffee(checkCoffeeModel);
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
